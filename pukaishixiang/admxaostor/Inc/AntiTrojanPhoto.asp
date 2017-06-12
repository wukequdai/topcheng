<%
'伪图片木马检查
Const adTypeBinary=1
Class AntiTrojanPhoto 
  Private jpg(1)
  Private bmp(1)
  Private png(3)
  Private gif(5)
  Private fstream,fileExt,stamp,i
  Private Sub Class_Initialize
    jpg(0)=CByte(&HFF):jpg(1)=CByte(&HD8)
    bmp(0)=CByte(&H42):bmp(1)=CByte(&H4D)
    png(0)=CByte(&H89):png(1)=CByte(&H50):png(2)=CByte(&H4E):png(3)=CByte(&H47)
    gif(0)=CByte(&H47):gif(1)=CByte(&H49):gif(2)=CByte(&H46):gif(3)=CByte(&H39):gif(4)=CByte(&H38):gif(5)=CByte(&H61)
    set fstream=Server.CreateObject ("Adodb." & "Str" & "eam")
  End Sub

  Private Sub Class_Terminate
  set fstream=nothing
  End Sub

  function CheckFileType(filename)
    CheckFileType=false
    filename=LCase(filename)
    fileExt=mid(filename,InStrRev(filename,".")+1)
    fstream.Open
    fstream.Type=adTypeBinary
    fstream.LoadFromFile filename
    fstream.position=0
    select case fileExt
      case "jpg","jpeg"
         stamp=fstream.read(2)
         for i=0 to 1
          if ascB(MidB(stamp,i+1,1))=jpg(i) then CheckFileType=true else CheckFileType=false
         next
      case "gif"
         stamp=fstream.read(6)
         for i=0 to 5
          if ascB(MidB(stamp,i+1,1))=gif(i) then CheckFileType=true else CheckFileType=false
         next
      case "png"
         stamp=fstream.read(4)
         for i=0 to 3
          if ascB(MidB(stamp,i+1,1))=png(i) then CheckFileType=true else CheckFileType=false
         next
       case "bmp"
         stamp=fstream.read(2)
         for i=0 to 1
          if ascB(MidB(stamp,i+1,1))=bmp(i) then CheckFileType=true else CheckFileType=false
         next
    end select
    fstream.Close
    if err.number<>0 then CheckFileType=false
  end function

End Class
%>