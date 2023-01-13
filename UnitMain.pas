unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ExtDlgs, Vcl.Buttons,
  System.ImageList, Vcl.ImgList;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    TabControl1: TTabControl;
    ActionList1: TActionList;
    actExit: TAction;
    actOpenModuleFile: TAction;
    OpenTextFileDialog1: TOpenTextFileDialog;
    Button3: TButton;
    actParseModuleFile: TAction;
    /// <summary>Exit from application</summary>
    procedure actExitExecute(Sender: TObject);
    /// <summary>Open Module text file</summary>
    procedure actOpenModuleFileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.actOpenModuleFileExecute(Sender: TObject);
begin
  //

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //
  ImageList1.GetBitmap(0, Image1.Picture.Bitmap);

end;

end.
