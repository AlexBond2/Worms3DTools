object ChgValForm: TChgValForm
  Left = 438
  Top = 438
  Width = 270
  Height = 163
  Caption = 'Change Values'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  DesignSize = (
    262
    131)
  PixelsPerInch = 96
  TextHeight = 13
  object Page: TPageControl
    Left = 0
    Top = 25
    Width = 262
    Height = 106
    ActivePage = TabSheet16
    Align = alClient
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'XString'
      TabVisible = False
      object ValXString: TComboBox
        Left = 16
        Top = 32
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'XFloat'
      ImageIndex = 1
      TabVisible = False
      object ValXFloat: TEditX
        Left = 24
        Top = 32
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 8
        LabelPosition = lpAbove
        LabelText = ' '
        LabelSpacing = 5
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'XVector'
      ImageIndex = 2
      TabVisible = False
      object ValXVectorX: TEditX
        Left = 24
        Top = 8
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'X'
        LabelSpacing = 5
        TabOrder = 0
      end
      object ValXVectorY: TEditX
        Left = 24
        Top = 32
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'Y'
        LabelSpacing = 5
        TabOrder = 1
      end
      object ValXVectorZ: TEditX
        Left = 24
        Top = 56
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'Z'
        LabelSpacing = 5
        TabOrder = 2
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'XInt'
      ImageIndex = 3
      TabVisible = False
      object ValXInt: TEditX
        Left = 24
        Top = 32
        Width = 121
        Height = 19
        FloatDiv = 1
        Precision = 0
        LabelPosition = lpAbove
        LabelText = ' '
        LabelSpacing = 5
        MaxValue = 2147483647
        MinValue = -1
        TabOrder = 0
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'XBool'
      ImageIndex = 4
      TabVisible = False
      object ValXBool: TComboBox
        Left = 16
        Top = 32
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'True'
        Items.Strings = (
          'False'
          'True')
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'XUint'
      ImageIndex = 5
      TabVisible = False
      object ValXUint: TEditX
        Left = 24
        Top = 32
        Width = 121
        Height = 19
        FloatDiv = 1
        Precision = 0
        LabelPosition = lpAbove
        LabelText = ' '
        LabelSpacing = 5
        MaxValue = 32767
        MinValue = -32768
        TabOrder = 0
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'XColor'
      ImageIndex = 6
      TabVisible = False
      object ValXColorA: TEditX
        Left = 64
        Top = 56
        Width = 81
        Height = 19
        FloatDiv = 1
        Precision = 0
        LabelPosition = lpLeft
        LabelText = 'Alpha'
        LabelSpacing = 5
        MaxValue = 255
        TabOrder = 0
      end
      object Button1: TButton
        Left = 96
        Top = 16
        Width = 59
        Height = 25
        Caption = 'Select'
        TabOrder = 1
        OnClick = Button1Click
      end
      object ColorP: TPanel
        Left = 64
        Top = 16
        Width = 25
        Height = 25
        BevelOuter = bvLowered
        Color = clWhite
        TabOrder = 2
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'XByte'
      ImageIndex = 7
      TabVisible = False
      object ValXByte: TEditX
        Left = 24
        Top = 32
        Width = 121
        Height = 19
        FloatDiv = 1
        Precision = 0
        LabelPosition = lpAbove
        LabelText = ' '
        LabelSpacing = 5
        MaxValue = 255
        TabOrder = 0
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'XPoint'
      ImageIndex = 8
      TabVisible = False
      object ValXPointX: TEditX
        Left = 24
        Top = 24
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'X'
        LabelSpacing = 5
        TabOrder = 0
      end
      object ValXPointY: TEditX
        Left = 24
        Top = 48
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'Y'
        LabelSpacing = 5
        TabOrder = 1
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'XFColor'
      ImageIndex = 9
      TabVisible = False
      object ValXFColorB: TEditX
        Left = 24
        Top = 56
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'B'
        LabelSpacing = 5
        MaxValue = 3
        MinValue = -3
        TabOrder = 0
      end
      object ValXFColorG: TEditX
        Left = 24
        Top = 32
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'G'
        LabelSpacing = 5
        MaxValue = 3
        MinValue = -3
        TabOrder = 1
      end
      object ValXFColorR: TEditX
        Left = 24
        Top = 8
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'R'
        LabelSpacing = 5
        MaxValue = 3
        MinValue = -3
        TabOrder = 2
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'XListInt'
      ImageIndex = 10
      TabVisible = False
      object ListIntVal: TComboBox
        Left = 16
        Top = 32
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'ListIntVal'
      end
    end
    object TabSheet12: TTabSheet
      Caption = 'XVectorR'
      ImageIndex = 2
      TabVisible = False
      object ValRVectorX: TEditX
        Left = 24
        Top = 8
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'X'
        LabelSpacing = 5
        TabOrder = 0
      end
      object ValRVectorY: TEditX
        Left = 24
        Top = 32
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'Y'
        LabelSpacing = 5
        TabOrder = 1
      end
      object ValRVectorZ: TEditX
        Left = 24
        Top = 56
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'Z'
        LabelSpacing = 5
        TabOrder = 2
      end
    end
    object TabSheet13: TTabSheet
      Caption = 'Vector4'
      ImageIndex = 12
      TabVisible = False
      object Vec4_1: TEditX
        Left = 24
        Top = 0
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'v1'
        LabelSpacing = 5
        TabOrder = 0
      end
      object Vec4_2: TEditX
        Left = 24
        Top = 24
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'v2'
        LabelSpacing = 5
        TabOrder = 1
      end
      object Vec4_3: TEditX
        Left = 24
        Top = 48
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'v3'
        LabelSpacing = 5
        TabOrder = 2
      end
      object Vec4_4: TEditX
        Left = 24
        Top = 72
        Width = 121
        Height = 19
        FloatDiv = 0.01
        Precision = 6
        LabelPosition = lpLeft
        LabelText = 'v4'
        LabelSpacing = 5
        TabOrder = 3
      end
    end
    object TabSheet14: TTabSheet
      Caption = 'XMatrix'
      ImageIndex = 13
      TabVisible = False
      object M1_1: TEditX
        Left = 0
        Top = 0
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M1_1'
        LabelSpacing = 5
        TabOrder = 0
      end
      object M2_1: TEditX
        Left = 0
        Top = 24
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M2_1'
        LabelSpacing = 5
        TabOrder = 1
      end
      object M3_1: TEditX
        Left = 0
        Top = 48
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M3_1'
        LabelSpacing = 5
        TabOrder = 2
      end
      object M4_1: TEditX
        Left = 0
        Top = 72
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M4_1'
        LabelSpacing = 5
        TabOrder = 3
      end
      object M1_2: TEditX
        Left = 48
        Top = 0
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M1_2'
        LabelSpacing = 5
        TabOrder = 4
      end
      object M2_2: TEditX
        Left = 48
        Top = 24
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M2_2'
        LabelSpacing = 5
        TabOrder = 5
      end
      object M3_2: TEditX
        Left = 48
        Top = 48
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M3_2'
        LabelSpacing = 5
        TabOrder = 6
      end
      object M4_2: TEditX
        Left = 48
        Top = 70
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M4_2'
        LabelSpacing = 5
        TabOrder = 7
      end
      object M1_3: TEditX
        Left = 96
        Top = 0
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M1_3'
        LabelSpacing = 5
        TabOrder = 8
      end
      object M2_3: TEditX
        Left = 96
        Top = 24
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M2_3'
        LabelSpacing = 5
        TabOrder = 9
      end
      object M3_3: TEditX
        Left = 96
        Top = 48
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M3_3'
        LabelSpacing = 5
        TabOrder = 10
      end
      object M4_3: TEditX
        Left = 96
        Top = 70
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M4_3'
        LabelSpacing = 5
        TabOrder = 11
      end
      object M1_4: TEditX
        Left = 144
        Top = 0
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M1_4'
        LabelSpacing = 5
        TabOrder = 12
      end
      object M2_4: TEditX
        Left = 144
        Top = 24
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M2_4'
        LabelSpacing = 5
        TabOrder = 13
      end
      object M3_4: TEditX
        Left = 144
        Top = 48
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M3_4'
        LabelSpacing = 5
        TabOrder = 14
      end
      object M4_4: TEditX
        Left = 144
        Top = 70
        Width = 33
        Height = 19
        FloatDiv = 0.01
        Precision = 2
        LabelPosition = lpLeft
        LabelText = 'M4_4'
        LabelSpacing = 5
        TabOrder = 15
      end
    end
    object TabSheet15: TTabSheet
      Caption = 'X4Char'
      ImageIndex = 14
      TabVisible = False
      object EditX4Char: TEdit
        Left = 40
        Top = 32
        Width = 153
        Height = 21
        MaxLength = 4
        TabOrder = 0
        Text = 'EditX4Char'
      end
    end
    object TabSheet16: TTabSheet
      Caption = 'XText'
      ImageIndex = 15
      TabVisible = False
      DesignSize = (
        254
        96)
      object ValXText: TRichEdit
        Left = 5
        Top = 3
        Width = 185
        Height = 89
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object Apply: TButton
    Left = 200
    Top = 61
    Width = 49
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Apply'
    ModalResult = 1
    TabOrder = 1
    OnClick = ApplyClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 262
    Height = 25
    Align = alTop
    BiDiMode = bdLeftToRight
    Caption = 'Value'
    ParentBiDiMode = False
    TabOrder = 2
  end
  object ColorD: TColorDialog
    Ctl3D = True
    Left = 216
    Top = 32
  end
end
