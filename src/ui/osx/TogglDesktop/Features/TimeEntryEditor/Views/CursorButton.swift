//
//  CursorButton.swift
//  TogglDesktop
//
//  Created by Nghia Tran on 3/26/19.
//  Copyright © 2019 Alari. All rights reserved.
//

import Foundation

class CursorButton: NSButton {

    // MARK: - Variable
    var didPressKey: ((Key, NSEvent.ModifierFlags) -> Void)?
    var cursor: NSCursor? {
        didSet {
            resetCursorRects()
        }
    }

    override func resetCursorRects() {
        if let cursor = cursor {
            addCursorRect(bounds, cursor: cursor)
        } else {
            super.resetCursorRects()
        }
    }

    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        if let key = Key(rawValue: Int(event.keyCode)) {
            didPressKey?(key, event.modifierFlags)
        }
    }

    private var _canBecomeKeyView = false
    override var canBecomeKeyView: Bool { _canBecomeKeyView }

    func setCanBecomeKeyView(_ canBecome: Bool) {
        _canBecomeKeyView = canBecome
    }
}
