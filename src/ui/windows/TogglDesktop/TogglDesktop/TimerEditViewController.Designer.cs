﻿namespace TogglDesktop
{
    partial class TimerEditViewController
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.textBoxDuration = new System.Windows.Forms.TextBox();
            this.buttonStart = new System.Windows.Forms.Button();
            this.timerRunningDuration = new System.Windows.Forms.Timer(this.components);
            this.linkLabelProject = new System.Windows.Forms.Label();
            this.linkLabelDescription = new System.Windows.Forms.Label();
            this.linkLabelDuration = new System.Windows.Forms.Label();
            this.labelClearProject = new System.Windows.Forms.Label();
            this.panelLeft = new System.Windows.Forms.Panel();
            this.durationPanel = new System.Windows.Forms.Panel();
            this.descriptionTextBox = new TogglDesktop.AutoCompleteTextBox();
            this.panelLeft.SuspendLayout();
            this.durationPanel.SuspendLayout();
            this.SuspendLayout();
            // 
            // textBoxDuration
            // 
            this.textBoxDuration.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.textBoxDuration.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(59)))), ((int)(((byte)(59)))), ((int)(((byte)(59)))));
            this.textBoxDuration.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.textBoxDuration.Font = new System.Drawing.Font("Lucida Sans Unicode", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(186)));
            this.textBoxDuration.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(185)))), ((int)(((byte)(185)))), ((int)(((byte)(185)))));
            this.textBoxDuration.Location = new System.Drawing.Point(4, 17);
            this.textBoxDuration.Name = "textBoxDuration";
            this.textBoxDuration.Size = new System.Drawing.Size(80, 28);
            this.textBoxDuration.TabIndex = 2;
            this.textBoxDuration.Text = "00:00:00";
            this.textBoxDuration.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.textBoxDuration.Enter += new System.EventHandler(this.textBoxDuration_Enter);
            this.textBoxDuration.Leave += new System.EventHandler(this.textBoxDuration_Leave);
            // 
            // buttonStart
            // 
            this.buttonStart.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(75)))), ((int)(((byte)(200)))), ((int)(((byte)(0)))));
            this.buttonStart.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.buttonStart.Dock = System.Windows.Forms.DockStyle.Right;
            this.buttonStart.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(75)))), ((int)(((byte)(200)))), ((int)(((byte)(0)))));
            this.buttonStart.FlatAppearance.BorderSize = 0;
            this.buttonStart.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonStart.Font = new System.Drawing.Font("Lucida Sans Unicode", 13F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(186)));
            this.buttonStart.ForeColor = System.Drawing.Color.White;
            this.buttonStart.Location = new System.Drawing.Point(259, 0);
            this.buttonStart.Margin = new System.Windows.Forms.Padding(0);
            this.buttonStart.Name = "buttonStart";
            this.buttonStart.Size = new System.Drawing.Size(55, 56);
            this.buttonStart.TabIndex = 3;
            this.buttonStart.Text = "Start";
            this.buttonStart.UseVisualStyleBackColor = false;
            this.buttonStart.Click += new System.EventHandler(this.buttonStart_Click);
            // 
            // timerRunningDuration
            // 
            this.timerRunningDuration.Interval = 1000;
            this.timerRunningDuration.Tick += new System.EventHandler(this.timerRunningDuration_Tick);
            // 
            // linkLabelProject
            // 
            this.linkLabelProject.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.linkLabelProject.Font = new System.Drawing.Font("Lucida Sans Unicode", 13F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(186)));
            this.linkLabelProject.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(185)))), ((int)(((byte)(185)))), ((int)(((byte)(185)))));
            this.linkLabelProject.Location = new System.Drawing.Point(17, 35);
            this.linkLabelProject.Name = "linkLabelProject";
            this.linkLabelProject.Size = new System.Drawing.Size(148, 20);
            this.linkLabelProject.TabIndex = 7;
            this.linkLabelProject.Text = "NEW - TOGGL";
            this.linkLabelProject.UseMnemonic = false;
            this.linkLabelProject.Visible = false;
            this.linkLabelProject.Click += new System.EventHandler(this.linkLabelProject_Click);
            this.linkLabelProject.MouseEnter += new System.EventHandler(this.linkLabelProject_Enter);
            // 
            // linkLabelDescription
            // 
            this.linkLabelDescription.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.linkLabelDescription.Font = new System.Drawing.Font("Lucida Sans Unicode", 13F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(186)));
            this.linkLabelDescription.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.linkLabelDescription.Location = new System.Drawing.Point(17, 0);
            this.linkLabelDescription.Name = "linkLabelDescription";
            this.linkLabelDescription.Size = new System.Drawing.Size(148, 23);
            this.linkLabelDescription.TabIndex = 8;
            this.linkLabelDescription.Text = "(no description)";
            this.linkLabelDescription.UseMnemonic = false;
            this.linkLabelDescription.Visible = false;
            this.linkLabelDescription.Click += new System.EventHandler(this.linkLabelDescription_Click);
            // 
            // linkLabelDuration
            // 
            this.linkLabelDuration.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.linkLabelDuration.Font = new System.Drawing.Font("Lucida Sans Unicode", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(186)));
            this.linkLabelDuration.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(185)))), ((int)(((byte)(185)))), ((int)(((byte)(185)))));
            this.linkLabelDuration.Location = new System.Drawing.Point(2, 32);
            this.linkLabelDuration.Margin = new System.Windows.Forms.Padding(0);
            this.linkLabelDuration.Name = "linkLabelDuration";
            this.linkLabelDuration.Size = new System.Drawing.Size(88, 23);
            this.linkLabelDuration.TabIndex = 9;
            this.linkLabelDuration.Text = "00:00:00";
            this.linkLabelDuration.TextAlign = System.Drawing.ContentAlignment.TopRight;
            this.linkLabelDuration.UseMnemonic = false;
            this.linkLabelDuration.Visible = false;
            this.linkLabelDuration.Click += new System.EventHandler(this.linkLabelDuration_Click);
            // 
            // labelClearProject
            // 
            this.labelClearProject.BackColor = System.Drawing.Color.Transparent;
            this.labelClearProject.Cursor = System.Windows.Forms.Cursors.Hand;
            this.labelClearProject.Enabled = false;
            this.labelClearProject.Font = new System.Drawing.Font("Lucida Sans Unicode", 13F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Pixel, ((byte)(0)));
            this.labelClearProject.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(185)))), ((int)(((byte)(185)))), ((int)(((byte)(185)))));
            this.labelClearProject.Location = new System.Drawing.Point(4, 35);
            this.labelClearProject.Name = "labelClearProject";
            this.labelClearProject.Size = new System.Drawing.Size(15, 20);
            this.labelClearProject.TabIndex = 10;
            this.labelClearProject.Text = "x";
            this.labelClearProject.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.labelClearProject.Visible = false;
            this.labelClearProject.Click += new System.EventHandler(this.labelClearProject_Click);
            // 
            // panelLeft
            // 
            this.panelLeft.Controls.Add(this.durationPanel);
            this.panelLeft.Controls.Add(this.linkLabelDescription);
            this.panelLeft.Controls.Add(this.labelClearProject);
            this.panelLeft.Controls.Add(this.descriptionTextBox);
            this.panelLeft.Controls.Add(this.linkLabelProject);
            this.panelLeft.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelLeft.Location = new System.Drawing.Point(0, 0);
            this.panelLeft.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.panelLeft.Name = "panelLeft";
            this.panelLeft.Size = new System.Drawing.Size(259, 56);
            this.panelLeft.TabIndex = 11;
            // 
            // durationPanel
            // 
            this.durationPanel.BackColor = System.Drawing.Color.Transparent;
            this.durationPanel.Controls.Add(this.textBoxDuration);
            this.durationPanel.Controls.Add(this.linkLabelDuration);
            this.durationPanel.Dock = System.Windows.Forms.DockStyle.Right;
            this.durationPanel.Location = new System.Drawing.Point(166, 0);
            this.durationPanel.Name = "durationPanel";
            this.durationPanel.Size = new System.Drawing.Size(93, 56);
            this.durationPanel.TabIndex = 11;
            // 
            // descriptionTextBox
            // 
            this.descriptionTextBox.AcceptsTab = true;
            this.descriptionTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.descriptionTextBox.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.CustomSource;
            this.descriptionTextBox.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(59)))), ((int)(((byte)(59)))), ((int)(((byte)(59)))));
            this.descriptionTextBox.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.descriptionTextBox.Font = new System.Drawing.Font("Lucida Sans Unicode", 13F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel, ((byte)(186)));
            this.descriptionTextBox.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(185)))), ((int)(((byte)(185)))), ((int)(((byte)(185)))));
            this.descriptionTextBox.Location = new System.Drawing.Point(20, 20);
            this.descriptionTextBox.Name = "descriptionTextBox";
            this.descriptionTextBox.Size = new System.Drawing.Size(145, 20);
            this.descriptionTextBox.TabIndex = 1;
            this.descriptionTextBox.Text = "What are you doing?";
            this.descriptionTextBox.Enter += new System.EventHandler(this.descriptionTextBox_Enter);
            this.descriptionTextBox.KeyUp += new System.Windows.Forms.KeyEventHandler(this.descriptionTextBox_KeyUp);
            this.descriptionTextBox.Leave += new System.EventHandler(this.descriptionTextBox_Leave);
            this.descriptionTextBox.PreviewKeyDown += new System.Windows.Forms.PreviewKeyDownEventHandler(this.descriptionTextBox_PreviewKeyDown);
            // 
            // TimerEditViewController
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(59)))), ((int)(((byte)(59)))), ((int)(((byte)(59)))));
            this.Controls.Add(this.panelLeft);
            this.Controls.Add(this.buttonStart);
            this.Margin = new System.Windows.Forms.Padding(0);
            this.Name = "TimerEditViewController";
            this.Size = new System.Drawing.Size(314, 56);
            this.panelLeft.ResumeLayout(false);
            this.panelLeft.PerformLayout();
            this.durationPanel.ResumeLayout(false);
            this.durationPanel.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox textBoxDuration;
        private System.Windows.Forms.Button buttonStart;
        private System.Windows.Forms.Timer timerRunningDuration;
        private System.Windows.Forms.Label linkLabelProject;
        private System.Windows.Forms.Label linkLabelDescription;
        private System.Windows.Forms.Label linkLabelDuration;
        private AutoCompleteTextBox descriptionTextBox;
        private System.Windows.Forms.Label labelClearProject;
        private System.Windows.Forms.Panel panelLeft;
        private System.Windows.Forms.Panel durationPanel;
    }
}
