object CompareTree: TCompareTree
  Left = 362
  Top = 208
  Width = 665
  Height = 593
  BorderIcons = []
  Caption = 'Compare Tree'
  Color = clBtnFace
  Constraints.MinHeight = 150
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 657
    Height = 512
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 329
      Top = 25
      Width = 3
      Height = 486
      Cursor = crHSplit
    end
    object InTree: TTreeView
      Left = 1
      Top = 25
      Width = 328
      Height = 486
      Align = alLeft
      Indent = 19
      ReadOnly = True
      TabOrder = 0
    end
    object OutTree: TTreeView
      Left = 332
      Top = 25
      Width = 324
      Height = 486
      Align = alClient
      Indent = 19
      ReadOnly = True
      TabOrder = 1
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 655
      Height = 24
      Align = alTop
      Caption = 
        'Import Xom3D work very unstable, I hope decide this problem in t' +
        'he future. AlexBond'
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 512
    Width = 657
    Height = 50
    Align = alBottom
    Constraints.MinHeight = 50
    Constraints.MinWidth = 374
    TabOrder = 1
    object Button2: TButton
      Left = 464
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 0
    end
    object Button1: TButton
      Left = 136
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Import'
      Enabled = False
      ModalResult = 1
      TabOrder = 1
    end
  end
end
