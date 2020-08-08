//
//  TimerViewModel.swift
//  TogglDesktop
//
//  Created by Andrew Nester on 28.07.2020.
//  Copyright © 2020 Toggl. All rights reserved.
//

import Foundation

final class TimerViewModel: NSObject {

    private(set) var entryDescription: String = "" {
        didSet {
            guard entryDescription != oldValue else { return }
            timeEntry.entryDescription = entryDescription
            onDescriptionChanged?(entryDescription)
        }
    }

    private(set) var durationString: String = "" {
        didSet {
            onDurationChanged?(durationString)
        }
    }

    private(set) var isRunning: Bool = false {
        didSet {
            onIsRunning?(isRunning)
        }
    }

    enum BillableState {
        case on
        case off
        case unavailable
    }

    private(set) var billableState: BillableState = .unavailable {
        didSet {
            guard billableState != oldValue else { return }
            let isBillable = billableState == .on

            if timeEntry.billable != isBillable {
                timeEntry.billable = isBillable

                if timeEntry.isRunning(), let timeEntryGUID = timeEntry.guid {
                    DesktopLibraryBridge.shared().setBillableForTimeEntryWithTimeEntryGUID(timeEntryGUID, isBillable: isBillable)
                }
            }

            onBillableChanged?(billableState)
        }
    }

    private var selectedTags: [String] = [] {
        didSet {
            if tagsDataSource.autoCompleteView != nil {
                tagsDataSource.updateSelectedTags(selectedTags.map { Tag(name: $0) })
            }

            let currentTags: [String] = timeEntry.tags ?? []
            if currentTags != selectedTags {
                timeEntry.tags = selectedTags

                if timeEntry.isRunning(), let timeEntryGUID = timeEntry.guid {
                    DesktopLibraryBridge.shared().updateTimeEntry(withTags: selectedTags, guid: timeEntryGUID)
                }
            }

            onTagSelected?(!selectedTags.isEmpty)
        }
    }

    // Bindings
    var onIsRunning: ((Bool) -> Void)?
    var onDescriptionChanged: ((String) -> Void)?
    var onDurationChanged: ((String) -> Void)?
    var onTagSelected: ((Bool) -> Void)?
    var onProjectSelected: ((Project?) -> Void)?
    var onBillableChanged: ((BillableState) -> Void)?
    var onDescriptionFocusChanged: ((Bool) -> Void)?
    var onTouchBarUpdateRunningItem: ((TimeEntryViewItem) -> Void)?

    // View outputs
    var isEditingDescription: (() -> Bool)?

    // !!!: it is needed for EditorViewController. Maybe it can be removed later.
    /// Timer tick notification will be posted every second if there is a running time entry.
    static let timerOnTickNotification = NSNotification.Name("TimerForRunningTimeEntryOnTicket")

    private var timeEntry = TimeEntryViewItem()
    private var notificationObservers: [AnyObject] = []

    var descriptionDataSource = LiteAutoCompleteDataSource(notificationName: kDisplayMinitimerAutocomplete)

    var projectDataSource = ProjectDataSource(items: ProjectStorage.shared.items,
                                                      updateNotificationName: .ProjectStorageChangedNotification)

    var tagsDataSource = TagDataSource(items: TagStorage.shared.tags,
                                              updateNotificationName: .TagStorageChangedNotification)

    private var timer: Timer!

    override init() {
        super.init()
        setupNotificationObservers()

        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerFired(_:)),
                                     userInfo: nil,
                                     repeats: true)

        projectDataSource.delegate = self

        tagsDataSource.delegate = self
        tagsDataSource.tagDelegate = self
    }

    deinit {
        cancelNotificationObservers()
        timer.invalidate()
    }

    func startStopAction() {
        if timeEntry.isRunning() {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kCommandStop), object: nil, userInfo: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kForceCloseEditPopover), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kCommandNew), object: timeEntry, userInfo: nil)
            onDescriptionFocusChanged?(false)

            descriptionDataSource.input?.resetTable()
            descriptionDataSource.clearFilter()
        }
    }

    func setDescriptionAutoCompleteInput(_ input: BetterFocusAutoCompleteInput) {
        descriptionDataSource.setFilter("")
        descriptionDataSource.input = input
        input.autocompleteTableView.delegate = self
    }

    func selectDescriptionAutoCompleteItem(at index: Int) -> Bool {
        guard let item = descriptionDataSource.item(at: index) else {
            return false
        }
        fillEntry(fromDescriptionAutocomplete: item)

        descriptionDataSource.input?.resetTable()
        descriptionDataSource.clearFilter()

        return true
    }

    func prepareData() {
        fetchTags()
        updateBillableStatus()
    }

    func setDescription(_ description: String) {
        entryDescription = description
        descriptionDataSource.setFilter(entryDescription)
        descriptionDataSource.input?.autocompleteTableView.resetSelected()
    }

    func descriptionDidEndEditing() {
        if timeEntry.isRunning(), let timeEntryGUID = timeEntry.guid {
            DesktopLibraryBridge.shared().updateTimeEntry(withDescription: entryDescription, guid: timeEntryGUID)
        }
    }

    func setBillable(_ isOn: Bool) {
        billableState = isOn ? .on : .off
    }

    // MARK: - Other

    private func fetchTags() {
        var workspaceID = timeEntry.workspaceID
        if workspaceID <= 0 {
            workspaceID = DesktopLibraryBridge.shared().defaultWorkspaceID()
        }
        DesktopLibraryBridge.shared().fetchTags(forWorkspaceID: workspaceID)
    }

    private func updateBillableStatus() {
        var workspaceID = timeEntry.workspaceID
        if workspaceID <= 0 {
            workspaceID = DesktopLibraryBridge.shared().defaultWorkspaceID()
        }
        let canSeeBillable = DesktopLibraryBridge.shared().canSeeBillable(forWorkspaceID: workspaceID)

        if canSeeBillable {
            billableState = timeEntry.billable ? .on : .off
        } else {
            billableState = .unavailable
        }
    }

    @objc
    private func timerFired(_ timer: Timer) {
        guard timeEntry.isRunning() else { return }

        let formattedDuration = DesktopLibraryBridge.shared().convertDuraton(inSecond: timeEntry.duration_in_seconds)
        durationString = formattedDuration

        NotificationCenter.default.post(name: Self.timerOnTickNotification, object: nil)
    }

    private func updateTimerState(with newTimeEntry: TimeEntryViewItem?) {
        let entry: TimeEntryViewItem
        if let timeEntry = newTimeEntry {
            entry = timeEntry
        } else {
            entry = TimeEntryViewItem()
        }

        let isNewWorkspace = entry.workspaceID != timeEntry.workspaceID
        let wasNotRunning = timeEntry.isRunning() == false

        timeEntry = entry

        isRunning = entry.isRunning()
        durationString = entry.duration ?? ""
        billableState = entry.billable ? .on : .off
        selectedTags = entry.tags ?? []

        if isRunning {
            let isEditing = isEditingDescription?() ?? true
            if entryDescription.isEmpty || wasNotRunning || !isEditing {
                entryDescription = entry.entryDescription ?? ""
            }
        } else {
            // don't update the description if user haven't yet started TE
            // so we don't interfere with his editing
        }

        if entry.isRunning() {
            onTouchBarUpdateRunningItem?(entry)
        }

        onProjectSelected?(Project(timeEntry: timeEntry))

        if isNewWorkspace {
            fetchTags()
        }

        updateBillableStatus()
    }

    private func focusTimer() {
        onDescriptionFocusChanged?(true)
    }

    private func timeEntryOnStop() {
        // updating description in case it wasn't yet updated
        // e.g. if TE was stopped by keyboard shortcut
        // and Timer haven't yet updated the contents of description field
        if !entryDescription.isEmpty {
            DesktopLibraryBridge.shared().updateTimeEntry(withDescription: entryDescription, guid: timeEntry.guid)
        }

        timeEntry = TimeEntryViewItem()

        isRunning = false
        entryDescription = ""
        durationString = ""
        selectedTags = []
        updateBillableStatus()
        focusTimer()

        onProjectSelected?(nil)
    }

    private func fillEntry(fromDescriptionAutocomplete autocompleteItem: AutocompleteItem) {
        // User has selected an autocomplete item.
        // It could be a time entry, a task or a project.

        if let newDescription = autocompleteItem.description {
            entryDescription = newDescription
        }

        fillEntryProject(from: autocompleteItem)

        selectedTags = autocompleteItem.tags ?? []

        if timeEntry.canSeeBillable {
            billableState = autocompleteItem.billable ? .on : .off
        } else {
            billableState = .unavailable
        }
    }

    private func fillEntryProject(from autocompleteItem: AutocompleteItem) {
        let isNewWorkspace = autocompleteItem.workspaceID != timeEntry.workspaceID

        timeEntry.workspaceID = UInt64(autocompleteItem.workspaceID)
        timeEntry.projectID = UInt64(autocompleteItem.projectID)
        timeEntry.taskID = UInt64(autocompleteItem.taskID)
        timeEntry.projectAndTaskLabel = autocompleteItem.projectAndTaskLabel
        timeEntry.taskLabel = autocompleteItem.taskLabel
        timeEntry.projectLabel = autocompleteItem.projectLabel
        timeEntry.clientLabel = autocompleteItem.clientLabel
        timeEntry.projectColor = autocompleteItem.projectColor

        if timeEntry.isRunning() {
            DesktopLibraryBridge.shared().setProjectForTimeEntryWithGUID(timeEntry.guid,
                                                                         taskID: timeEntry.taskID,
                                                                         projectID: timeEntry.projectID,
                                                                         projectGUID: autocompleteItem.projectGUID)
        }

        onProjectSelected?(Project(timeEntry: timeEntry))

        if isNewWorkspace {
            fetchTags()
            updateBillableStatus()
            selectedTags = []
        }
    }

    // MARK: - Notifications handling

    private func setupNotificationObservers() {
        let displayTimerStateObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(kDisplayTimerState),
                                                                               object: nil,
                                                                               queue: .main) { [weak self] notification in
            self?.updateTimerState(with: notification.object as? TimeEntryViewItem)
        }

        let focusTimerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(kFocusTimer),
                                                                        object: nil,
                                                                        queue: .main) { [weak self] _ in
            self?.focusTimer()
        }

        let commandStopObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(kCommandStop),
                                                                         object: nil,
                                                                         queue: .main) { [weak self] _ in
            self?.timeEntryOnStop()
        }

        let startTimerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(kStartTimer),
                                                                        object: nil,
                                                                        queue: .main) { [weak self] _ in
            self?.startStopAction()
        }

        notificationObservers = [displayTimerStateObserver, focusTimerObserver, commandStopObserver, startTimerObserver]
    }

    private func cancelNotificationObservers() {
        notificationObservers.forEach {
            NotificationCenter.default.removeObserver($0)
        }
    }
}

// MARK: - Autocomplete NSTableViewDelegate

// TODO: consider moving into separate file/type
extension TimerViewModel: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let autocompleteTable = tableView as! AutoCompleteTable
        autocompleteTable.setCurrentSelected(row, next: true)
        return true
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let row = descriptionDataSource.input?.autocompleteTableView.selectedRow, row >= 0 else {
            return
        }

        guard let item = descriptionDataSource.item(at: row),
            item.type >= 0 else {
                // category clicked
                return
        }

        fillEntry(fromDescriptionAutocomplete: item)

        descriptionDataSource.input?.resetTable()
        descriptionDataSource.clearFilter()
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard row >= 0, row < descriptionDataSource.filteredOrderedKeys.count else {
            return nil
        }

        guard let item = descriptionDataSource.filteredOrderedKeys.object(at: row) as? AutocompleteItem else {
            return nil
        }
        let autocompleteTable = tableView as! AutoCompleteTable

        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("AutoCompleteTableCell"),
                                      owner: self) as! AutoCompleteTableCell
        let renderSelected = autocompleteTable.lastSelected != -1 && autocompleteTable.lastSelected == row
        cell.render(item, selected: renderSelected)
        return cell
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        guard let item = descriptionDataSource.filteredOrderedKeys.object(at: row) as? AutocompleteItem,
            let inputField = descriptionDataSource.input else {
                return 0
        }
        let cellType = AutoCompleteTableCell.cellType(from: item)

        switch cellType {
        case .workspace:
            return inputField.worksapceItemHeight
        default:
            return inputField.itemHeight
        }
    }
}

// MARK: - Project struct

extension TimerViewModel {

    struct Project {
        let color: NSColor
        let attributedTitle: NSAttributedString

        init?(timeEntry: TimeEntryViewItem) {
            guard timeEntry.projectLabel != nil, timeEntry.projectLabel.isEmpty == false else {
                return nil
            }
            self.color = ConvertHexColor.hexCode(toNSColor: timeEntry.projectColor)
            self.attributedTitle = ProjectTitleFactory().title(for: timeEntry)
        }
    }
}

// MARK: - AutoCompleteViewDataSourceDelegate

extension TimerViewModel: AutoCompleteViewDataSourceDelegate {

    func autoCompleteSelectionDidChange(sender: AutoCompleteViewDataSource, item: Any) {
        if sender == projectDataSource {
            guard let projectItem = item as? ProjectContentItem else {
                return
            }
            fillEntryProject(from: projectItem.item)
        }
    }
}

extension TimerViewModel: TagDataSourceDelegate {

    func tagSelectionChanged(with selectedTags: [Tag]) {
        self.selectedTags = selectedTags.map { $0.name }
    }
}
