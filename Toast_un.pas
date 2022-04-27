unit Toast_un;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants;

type
  TToastLength = (LongToast, ShortToast);

type
  TToastMessage = class
  private
    { Private declarations }
  public
    { Public declarations }
{$IFDEF ANDROID}
    procedure Toast(const Msg: string; duration: TToastLength);
{$ENDIF}
  end;

implementation
{$IFDEF ANDROID}

uses
  Androidapi.JNI.Widget,
  Androidapi.Helpers,
  FMX.Helpers.Android;

procedure TToastMessage.Toast(const Msg: string; duration: TToastLength);
var
  ToastLength: Integer;
begin
  if duration = ShortToast then
    ToastLength := TJToast.JavaClass.LENGTH_SHORT
  else
    ToastLength := TJToast.JavaClass.LENGTH_LONG;

  CallInUiThread(
    procedure
    begin
      TJToast.JavaClass.makeText(SharedActivityContext, StrToJCharSequence(Msg),
        ToastLength).show
    end);
end;
{$ENDIF}

end.

