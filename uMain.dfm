object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 559
  ClientWidth = 949
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  TextHeight = 15
  object TPanel
    Left = 0
    Top = 0
    Width = 949
    Height = 49
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 945
    object Label1: TLabel
      Left = 465
      Top = 11
      Width = 48
      Height = 15
      Caption = 'Tuile N'#176' :'
    end
    object BitBtn1: TBitBtn
      Left = 40
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Create'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 136
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Dispose'
      TabOrder = 1
      Visible = False
      OnClick = BitBtn2Click
    end
    object ComboBox1: TComboBox
      Left = 792
      Top = 8
      Width = 145
      Height = 23
      TabOrder = 2
      Text = 'ComboBox1'
      Visible = False
    end
    object BitBtn3: TBitBtn
      Left = 248
      Top = 8
      Width = 107
      Height = 25
      Caption = 'Change Tuile Values'
      TabOrder = 3
      OnClick = BitBtn3Click
    end
    object cxSpinEdit1: TcxSpinEdit
      Left = 513
      Top = 8
      TabOrder = 4
      Value = 1
      Width = 64
    end
    object cxSpinEdit2: TcxSpinEdit
      Left = 361
      Top = 8
      TabOrder = 5
      Value = 1
      Width = 64
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 949
    Height = 184
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 945
  end
end
