unit uTuilleDevExpress;

interface

uses
  dxCustomTileControl ,
  uTuilleInterf ,
  dxTileControl ,
  System.Classes,
  VCL.Controls ,
  VCL.Graphics ,
  System.Generics.Collections
  ;

type

 TColorsOfdxTuile = Record
      BorderColor        : TColor ;
      GradientBeginColor : TColor ;
      GradientEndColor   : TColor ;
  end;

 TdxTuilePanel  = class(TInterfacedObject, ITuilePanel)
  strict private
     FTileControl: TdxTileControl;
  protected
     FItems : TObjectDictionary<string ,ITuileItem>   ;
     function  fGetTuileItemByID(aTuileID : Integer  ) : ITuileItem ;
     procedure pAddTuile(var InfosTuile : TInfoTuile ; Event : TTuileItemEvent ) ;
  public
    constructor Create(const Owner : TComponent; const parent : TWinControl );
    destructor Destroy; override;
    function AsdxTileControl: TdxTileControl;
//    procedure Show;
    property  TileControl: TdxTileControl Read  FTileControl ;
  end;


 TdxTuileItem = class(TInterfacedObject, ITuileItem)
  strict private
    FdxTileControlItem: TdxTileControlItem;
    FOnClick: TTuileItemEvent;
  private

  strict protected
    function GetText1: string;
    function GetText2: string;
    function GetText3: string;
    function GetOnClick: TTuileItemEvent;
    procedure HandleClick(Sender: TdxTileControlItem);
    procedure SetText1(const value: string);
    procedure SetText2(const value: string);
    procedure SetText3(const value: string);
    procedure SetOnClick(const value: TTuileItemEvent);
  public
    constructor Create(owner: ITuilePanel ; InfosTuile: TInfoTuile; Event: TTuileItemEvent);
    property Text1: string read GetText1 write SetText1;
    property Text2: string read GetText2 write SetText2;
    property Text3: string read GetText3 write SetText3;
    property OnClick: TTuileItemEvent read GetOnClick write SetOnClick;
 end;


 TdxTuilePanelFactory = class(TInterfacedObject, ITuilePanelFactory)
 public
    function CreateTuilePanel(const Owner : TComponent; const parent : TWinControl) : ITuilePanel;
    function CreateTuileItem(const TuilePanel: ITuilePanel ;InfosTuile : TInfoTuile ; Event : TTuileItemEvent): ITuileItem;
  end;


 TAbstractTuile = class
  strict private
    FFactory: ITuilePanelFactory;
    FTuilePanel: ITuilePanel;
  public
    constructor Create(const factory: ITuilePanelFactory);
    procedure Make(const Owner : TComponent; const parent : TWinControl; Items :  TStrings;
                    CallBack : TTuileItemEvent);
    property TuilePanel: ITuilePanel  Read FTuilePanel ;

  end;

//function  _TColorsOfdxTuile(BorderColor, GradientBeginColor ,  GradientEndColor : TColor) :  TColorsOfdxTuile ;

var


 // Declare and initialize a constant array of records
  _Colors : array[0..5] of TColorsOfdxTuile = (
    (BorderColor: $00804000; GradientBeginColor:$20BA5C22  ;   GradientEndColor :$00F58B4B ),
    (BorderColor: $20B9AA1A; GradientBeginColor:$20998200  ;   GradientEndColor :$20B1A000) ,
    (BorderColor: $20A01A98; GradientBeginColor:$2095008C  ;   GradientEndColor :$20AE00A7 ),
    (BorderColor: $00291D1D; GradientBeginColor:$00966B6C  ;   GradientEndColor :$00BEA5A6 ),
    (BorderColor: $00C65274; GradientBeginColor:$00AB3351  ;   GradientEndColor :$20BF3E64)  ,
    (BorderColor: $203C5AD7; GradientBeginColor:$202647D2  ;   GradientEndColor :$202E56DC)

  );

implementation

uses
  dxSkinsCore,
  System.SysUtils
;

function TdxTuilePanel.AsdxTileControl: TdxTileControl;
begin
  result := FTileControl ;
end;

constructor TdxTuilePanel.Create(const Owner : TComponent ; const parent : TWinControl );
begin
   inherited Create;
   FItems := TObjectDictionary<string ,ITuileItem>.Create();

   FTileControl :=  TdxTileControl.Create(Owner);
   FTileControl.Parent :=  parent ;
   FTileControl.Align := alClient;
   With FTileControl Do
   begin
      Left := 0  ;
      Top  := 70   ;
//      Width = 980 ;
//      Height = 157 ;
      Margins.Left  := 2  ;
      Margins.Top   := 2  ;
      Margins.Right := 2 ;
      Margins.Bottom := 2 ;
//      Images = ImageList
      OptionsBehavior.ItemMoving := False ;
      OptionsBehavior.ScrollMode := smScrollButtons  ;
      OptionsDetailAnimate.AnimationMode := damScrollFade  ;
      OptionsView.IndentHorz := 20 ;
      OptionsView.IndentVert := 20 ;
//      TabOrder := 0  ;
      Transparent := True ;
//      ExplicitLeft := 2 ;
   end;

   var  NewGroup: TdxTileControlGroup;
   NewGroup := FTileControl.CreateGroup;
   NewGroup.Index := 0;  // Set position
   NewGroup.Caption.Text := 'New Group';

end;

destructor TdxTuilePanel.Destroy;
begin
//  FreeAndNil(FTileControl) ;
  FreeAndNil(FItems) ;
  inherited;
end;

function TdxTuilePanel.fGetTuileItemByID(aTuileID: Integer): ITuileItem;
var
    vTuileItem: ITuileItem ;
begin
  Result := nil ;

  var i:  integer ;
  var  vdxTileControlItem: TdxTileControlItem := nil;

  for i:= 0 to  FTileControl.Groups[0].ItemCount- 1 do
  begin
    if FTileControl.Groups[0].Items[i].Tag = Ord(aTuileID)  then
      vdxTileControlItem :=  FTileControl.Groups[0].Items[i] ;
  end;

  if Assigned(vdxTileControlItem) then
  begin
    if FItems.TryGetValue(vdxTileControlItem.Name , vTuileItem) Then
      result := vTuileItem;
  end;



end;

procedure TdxTuilePanel.pAddTuile(var InfosTuile: TInfoTuile; Event: TTuileItemEvent);
begin
  var vTuileItem : TdxTuileItem ;
  vTuileItem := TdxTuileItem.Create(Self,InfosTuile , event) ;
  FItems.Add(InfosTuile.Name, vTuileItem) ;
end;

//procedure TdxTuilePanel.Show;
//begin
//
//end;

{ TdxTuileItem }

constructor TdxTuileItem.Create(owner: ITuilePanel ; InfosTuile: TInfoTuile; Event: TTuileItemEvent);
begin
  var vdxTileControlGroup1 :TdxTileControlGroup :=   TdxTuilePanel(owner).TileControl.Groups[0] ;
  var idx : Integer := 0 ;
  var idxColor : Integer;

  Self.OnClick :=  Event;
  FdxTileControlItem := TdxTuilePanel(owner).TileControl.CreateItem(tcisRegular, vdxTileControlGroup1);
  With FdxTileControlItem Do
    begin
      Name :=   InfosTuile.name;
      Glyph.ImageIndex := InfosTuile.ID -1  ;
      Glyph.Align := oaTopRight ;
      Style.Gradient  := gmVertical ;

      idxColor :=    vdxTileControlGroup1.ItemCount Mod Length(_Colors)  ;

      Style.BorderColor        := _Colors[idxColor].BorderColor ; // $00804000;
      Style.GradientBeginColor := _Colors[idxColor].GradientBeginColor  ; // $20BA5C22;
      Style.GradientEndColor   := _Colors[idxColor].GradientEndColor ; // $00F58B4B;

      Tag := InfosTuile.ID ;
      Text1.Value := InfosTuile.Text1; // + viSeq.ToString();
      Text1.Font.Size  := 11 ;
      Text1.Font.Style := [fsBold] ;

      Text2.Value := InfosTuile.Text2 ; //Random(10).ToString;
      Text2.Font.Size  := 26 ;
      Text2.Font.Style := [fsBold] ;
      Text2.Align := oaMiddleCenter ;

      Text3.Value := InfosTuile.Text3 ;
      Text3.Font.Size  := 9 ;
      Text3.Font.Style := [] ;
      Text3.Align := oaBottomCenter ;
      Text3.Alignment := taCenter ;
      Text3.WordWrap := True ;

      FdxTileControlItem.OnClick := HandleClick ;

    end;
end;

function TdxTuileItem.GetOnClick: TTuileItemEvent;
begin
  result := Self.FOnClick ;
end;

procedure TdxTuileItem.SetOnClick(const value: TTuileItemEvent);
begin
  Self.FOnClick :=  value;
end;

procedure TdxTuileItem.HandleClick(Sender: TdxTileControlItem);
begin
    Self.FOnClick(Sender);
end;

procedure TdxTuileItem.SetText1(const value: string);
begin
   FdxTileControlItem.Text1.Value := value ;
end;

procedure TdxTuileItem.SetText2(const value: string);
begin
   FdxTileControlItem.Text2.Value := value ;
end;

procedure TdxTuileItem.SetText3(const value: string);
begin
   FdxTileControlItem.Text3.Value := value ;
end;

function TdxTuileItem.GetText1 : string;
begin
   Result := FdxTileControlItem.Text1.Value ;
end;

function TdxTuileItem.GetText2: string;
begin
   Result := FdxTileControlItem.Text2.Value ;
end;

function TdxTuileItem.GetText3: string;
begin
   Result := FdxTileControlItem.Text3.Value ;
end;


{ TdxTuilePanelFactory }

function TdxTuilePanelFactory.CreateTuileItem( const TuilePanel: ITuilePanel;
                         InfosTuile : TInfoTuile ; Event : TTuileItemEvent): ITuileItem;
begin
 // result := TdxTuileItem.Create(TuilePanel , InfosTuile , event);
end;

function TdxTuilePanelFactory.CreateTuilePanel(const Owner : TComponent; const parent : TWinControl): ITuilePanel;
begin
   result := TdxTuilePanel.Create(Owner , parent) ;
end;

{ TAbstractTuile }

constructor TAbstractTuile.Create(const factory: ITuilePanelFactory);
begin
  inherited Create;
  FFactory := factory;
end;

procedure TAbstractTuile.Make(const Owner : TComponent; const parent : TWinControl ;
       Items :  TStrings;  CallBack : TTuileItemEvent);
begin
  Self.FTuilePanel := FFactory.CreateTuilePanel(Owner, parent);

  var vi : Smallint ;
  var  viSeq  : Smallint ;
  var vsDesPrio : String  := '';
  var vInfosTuile : TInfoTuile  ;

  for vi := 0 to Items.Count-1  do
  begin

    viSeq := Integer(Items.Objects[vi]) ;

    if viSeq <0  then
      Continue ;
    vsDesPrio :=  Items[vi];
    vInfosTuile.name :='item_tuile'+viSeq.ToString;
    vInfosTuile.ID := viSeq ;
    vInfosTuile.Text1 :=  'Priorité' ;
    vInfosTuile.Text2  :=   Random(10).ToString ;
    vInfosTuile.Text3  :=vsDesPrio;

    FTuilePanel.pAddTuile(vInfosTuile ,  CallBack ) ;
//    FFactory.CreateTuileItem(FTuilePanel , vInfosTuile ,  CallBack) ;
  end;
//
//  FButton.OnClick :=
//    procedure
//    begin
//      FListbox.Add(FEdit.GetText);
//    end;
end;

function  _TColorsOfdxTuile(BorderColor, GradientBeginColor ,  GradientEndColor : TColor) :   TColorsOfdxTuile ;
begin
  Result.BorderColor :=  BorderColor ;
  Result.GradientBeginColor :=  GradientBeginColor ;
  Result.GradientEndColor :=  GradientEndColor ;
end;

end.
