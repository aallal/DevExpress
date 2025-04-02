unit uTuilleInterf;

interface

uses
  System.SysUtils,
  System.Classes,
  VCL.Controls
  ;

Type
  /// <summary>
  /// Information pour créer une tuile
  /// </summary>
  TInfoTuile  = Record
    name : string ;
    ID : Integer ;
    Text1 : string ;
    Text2 : string ;
    Text3 : string ;
  End;


  // Efvent pour gérer le click sur uen tuile
  TTuileItemEvent = procedure(Sender: TComponent) of object;

  // Une interface de type tuile ça peut être un composant DevEXpress TdxTileControlItem  ou autre
  // Important !  à ce niveau on ne fait aucunne référence vers DevEXpress, ça doit rester générique
  ITuileItem = Interface['{EA0337E2-0211-4471-9E8D-8186A6E5F6BF}']
    function GetText1 : string ;
    function GetText2 : string ;
    function GetText3 : string ;
    procedure SetText1(const value: string);
    procedure SetText2(const value: string);
    procedure SetText3(const value: string);

    function GetOnClick: TTuileItemEvent;
    property Text1: string read GetText1 write SetText1;
    property Text2: string read GetText2 write SetText2;
    property Text3: string read GetText3 write SetText3;

    procedure SetOnClick(const value: TTuileItemEvent);

    property OnClick: TTuileItemEvent read GetOnClick write SetOnClick;
  End;

  // Interface de type panel de tuile  : TdxTileControl pour une implémentation en devEXpress
  ITuilePanel = Interface['{50A04DBD-CEF0-4E19-BC36-993757890554}']
      function  fGetTuileItemByID(aTuileID : Integer  ) : ITuileItem ;
      procedure pAddTuile(var InfosTuile : TInfoTuile ; Event : TTuileItemEvent ) ;
  End;

  // Interface Fabrique du  panel de tuile
  ITuilePanelFactory = interface ['{21D79AEF-B0D2-4BC6-8E43-CE64C356A199}']
    function CreateTuilePanel(const Owner : TComponent; const parent : TWinControl) : ITuilePanel;
    function CreateTuileItem(const TuilePanel: ITuilePanel ;InfosTuile : TInfoTuile ; Event : TTuileItemEvent): ITuileItem;
  end;




implementation

{ TdxTuilePanel }

end.






