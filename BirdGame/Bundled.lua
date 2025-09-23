local a a={cache={},load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}
end return a.cache[b].c end}do function a.a()return{Bird={Gravity=0.075,
JumpDebounce=0.1,Size=0.2,AspectRatio=1.417,XPos=0.1,StartPos=0.5,JumpPower=
0.025,AnimCycleDelay=0.06,AnimOffsets={[1]=Vector2.new(0,0),[2]=Vector2.new(34,0
),[3]=Vector2.new(17,0)}},ScrollSpeed=0.5,ObstacleSpawnRate=4.5}end function a.b
()local b=a.load'a'local c={}c.__index=c function c.new(d)local e=setmetatable({
},c)e.Sprite=Instance.new'ImageLabel'e.Sprite.BackgroundTransparency=1 e.Sprite.
Image='rbxassetid://115681505979622'e.Sprite.ImageRectSize=Vector2.new(17,12)e.
Sprite.Size=UDim2.fromScale(b.Bird.Size,b.Bird.Size/b.Bird.AspectRatio)e.Sprite.
ResampleMode=Enum.ResamplerMode.Pixelated e.Sprite.ZIndex=1 e.Sprite.Visible=
false e.Sprite.Parent=d e.Velocity=0 e.Position=b.Bird.StartPos e._AnimCycle=1 e
._AnimDB=0 e._ct=0 return e end function c.Update(d,e,f)d._ct+=e if f then d.
Velocity=-b.Bird.JumpPower else d.Velocity+=b.Bird.Gravity*e end d:SetPosition(d
.Position+d.Velocity)d.Sprite.Rotation=d.Velocity*1500 if d.Velocity<0 then if d
._ct-d._AnimDB>b.Bird.AnimCycleDelay then d._AnimDB=d._ct d:SetAnimState(d.
_AnimCycle)d._AnimCycle=d._AnimCycle%3+1 end else d:SetAnimState(2)d._AnimCycle=
2 end end function c.SetMenuVisibility(d,e)d.Sprite.Visible=e or false end
function c.SetPosition(d,e)local f,g=0,1-d.Sprite.Size.Y.Scale local h=math.
clamp(e,f,g)if h==f or h==g then d.Velocity=0 end d.Position=h d.Sprite.Position
=UDim2.fromScale(b.Bird.XPos,h)end function c.SetAnimState(d,e)d.Sprite.
ImageRectOffset=b.Bird.AnimOffsets[e]or Vector2.new(0,0)end function c.Destroy(d
)d.Sprite:Destroy()end return c end function a.c()local b=function(b)local c=b.
AbsolutePosition local d=b.AbsoluteSize local e=c.X local f=c.X+d.X local g=c.Y
local h=c.Y+d.Y return e,f,g,h end local c=function(c,d)local e,f,g,h=b(c)local
i,j,k,l=b(d)return f>i and j>e and h>k and l>g end local d={}d.Pool={}d.__index=
d function d.new(e)local f=setmetatable({},d)local g=math.random()*0.4+0.3 f.Top
=Instance.new'ImageLabel'f.Bottom=Instance.new'ImageLabel'f.Top.Image=
'rbxassetid://102293851027889'f.Bottom.Image='rbxassetid://102452434254295'f.Top
.AnchorPoint=Vector2.new(0,1)f.Top.Position=UDim2.fromScale(1,g-0.27)f.Bottom.
Position=UDim2.fromScale(1,g+0.27)f.Destroyed=false f.Cleared=false for h,i in{f
.Bottom,f.Top}do i.Size=UDim2.fromScale(0.214,1.231)i.BackgroundTransparency=1 i
.ResampleMode=Enum.ResamplerMode.Pixelated i.ZIndex=e.ZIndex+1 i.Parent=e end
table.insert(d.Pool,f)return f end function d.Update(e,f,g)e.Top.Position-=UDim2
.fromScale(g*f,0)e.Bottom.Position-=UDim2.fromScale(g*f,0)if e.Top.Position.X.
Scale<-0.5 then e:Destroy()end end function d.IsColliding(e,f)return c(e.Top,f)
or c(e.Bottom,f)end function d.CheckCleared(e,f)if not e.Cleared then e.Cleared=
f.AbsolutePosition.X>(e.Top.AbsolutePosition.X+e.Top.AbsoluteSize.X)end return e
.Cleared end function d.Destroy(e)e.Destroyed=true local f=table.find(d.Pool,e)
table.remove(d.Pool,f)e.Top:Destroy()e.Bottom:Destroy()end function d.
DestroyPool()for e,f in d.Pool do f:Destroy()end end return d end function a.d()
local b=function(b,c)b.ImageRectOffset=Vector2.new(16*math.clamp(c or 0,0,9),0)
end local c={}c.__index=c function c.new(d)local e=setmetatable({Frame=Instance.
new'Frame',Digits={},Parent=nil,Size=UDim2.fromScale(0.5,0.5),Position=UDim2.
fromScale(0.5,0.5),AnchorPoint=Vector2.new(0,0),Value=0},c)local f=e.Frame f.
BackgroundTransparency=1 local g=Instance.new'UIListLayout'g.FillDirection=Enum.
FillDirection.Horizontal g.SortOrder=Enum.SortOrder.LayoutOrder g.
HorizontalAlignment=Enum.HorizontalAlignment.Left g.Padding=UDim.new(0.05,0)g.
VerticalAlignment=Enum.VerticalAlignment.Center g.HorizontalFlex=Enum.
UIFlexAlignment.Fill g.Parent=f for h=1,d or 3 do local i=Instance.new
'ImageLabel'i.Image='rbxassetid://99344985316108'i.ImageRectSize=Vector2.new(16,
16)i.ResampleMode=Enum.ResamplerMode.Pixelated i.LayoutOrder=h i.ScaleType=Enum.
ScaleType.Fit i.Size=UDim2.fromScale(0.3333333333333333,1)i.
BackgroundTransparency=1 i.Parent=f table.insert(e.Digits,i)end return e end
function c.SetValue(d,e)local f=tostring(e):split''while#f<#d.Digits do table.
insert(f,1,'0')end for g,h in d.Digits do local i=tonumber(f[h.LayoutOrder]or 0)
b(h,i)end end function c.Destroy(d)d.Frame:Destroy()end return c end function a.
e()local b=a.load'd'local c={}c.__index=c function c.new(d)local e=setmetatable(
{Canvas=d,Menu={Container=Instance.new'Frame',Background=Instance.new
'ImageLabel',Logo=Instance.new'ImageLabel',PlayButton=Instance.new'ImageLabel',
ScoreLabel=b.new(3)}},c)local f=e.Menu local g=f.Container g.Size=UDim2.
fromScale(1,1)g.BackgroundTransparency=1 g.Visible=false g.Parent=d local h=f.
Logo h.AnchorPoint=Vector2.new(0.5,0)h.ResampleMode=Enum.ResamplerMode.Pixelated
h.BackgroundTransparency=1 h.Image='rbxassetid://135353986238221'h.Size=UDim2.
fromScale(0.66,0.178)h.Position=UDim2.fromScale(0.5,0.264)h.ZIndex=1 h.Parent=g
local i=f.PlayButton i.AnchorPoint=Vector2.new(0.5,0)i.ResampleMode=Enum.
ResamplerMode.Pixelated i.BackgroundTransparency=1 i.Image=
'rbxassetid://92637228175954'i.Size=UDim2.fromScale(0.449,0.251)i.Position=UDim2
.fromScale(0.5,0.473)i.ZIndex=1 i.Parent=g local j=f.Background j.ResampleMode=
Enum.ResamplerMode.Pixelated j.Image='rbxassetid://79739641355792'j.Size=UDim2.
fromScale(1,1)j.ZIndex=0 j.Parent=d local k=f.ScoreLabel local l=k.Frame l.
AnchorPoint=Vector2.new(0.5,0)l.Size=UDim2.fromScale(0.3,0.1)l.Position=UDim2.
fromScale(0.5,0)l.ZIndex=2 l.Parent=j e:SetScore(0)return e end function c.
SetScore(d,e)d.Menu.ScoreLabel:SetValue(e)end function c.SetMenuVisibility(d,e)d
.Menu.Container.Visible=e or false end return c end end local b=a.load'a'local c
=a.load'b'local d=a.load'c'local e=a.load'e'local f=assert(Network:GetPart
'Screen','no connected screen')local g=assert(Network:GetPort(1),
'no connected port with id of 1')f:ClearElements()local h=f:GetCanvas()local i=e
.new(h)local j=false g.Triggered:Connect(function()j=true end)while true do i:
SetMenuVisibility(true)if j then j=false i:SetMenuVisibility(false)local k=c.
new(i.Menu.Background)k.Sprite.Visible=true d.new(i.Menu.Background)local l=0 i:
SetScore(l)local m=0 local n=0 local o=true while o do local p=task.wait()n+=p m
+=p k:Update(p,j)if m>b.ObstacleSpawnRate then m=0 d.new(i.Menu.Background)end
for q,r in d.Pool do r:Update(p,b.ScrollSpeed)if r:IsColliding(k.Sprite)then o=
false break end if not r.Cleared then local s=r:CheckCleared(k.Sprite)if s then
l+=1 i:SetScore(l)end end end if j then j=false end end k:Destroy()d.
DestroyPool()end task.wait(0.1)end