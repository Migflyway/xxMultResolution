init("0", 1); --以当前应用 Home 键在右边初始化


--height is large, width is small for a phone
-- 首先要明白缩放比，再进行处理
-- 对于一个 控件，有一个锚点【及原点】，算出在开发分辨率下与原点的位置。再按照缩放比进行缩放，然后即可带入到新的锚点中去 求出新坐标

--16 / 9
-- 0.5625
dep_width, dep_height = 720, 1280
dep_x = math.max(dep_width,dep_height)
dep_y = math.min(dep_width,dep_height)

print("开发环境 x轴"..dep_x.." y轴"..dep_y)
----开发环境9点坐标系统
dep_nine_pos = {
	{0,0},
	{dep_x/2,0},
	{dep_x,0},
	
	{0,dep_y/2},
	{dep_x/2,dep_y/2},
	{dep_x,dep_y/2},
	
	{0,dep_y},
	{dep_x/2,dep_y},
	{dep_x,dep_y}
}

--------实际坐标系
--------需要考虑黑边
----这里加入自动检测黑白，让其所有数值进行偏移

--width,height = getScreenSize()
-- 0.75
width,height = 768, 1024

--发现这种黑边处理有点问题
--[[

local dif_width, dif_height = 0, 0

-- 纵向检测
-- 从高的中间开始检测
for i=1, width,1 do
	if getColor(height/2, i) == 0x000000 then
		dif_width = dif_width + 1
	else
		print("黑边检测完成，偏移"..dif_width)
		break
	end
end


-- 横向检测
-- 从宽的中间开始检测
for i=1, height,1 do
	if getColor(i, width/2) == 0x000000 then
		dif_height = dif_height + 1
	else
		print("黑边检测完成，偏移"..dif_height)
		break
	end
end
]]
--- 4 / 3 (4 * 4 = 16 / 12)
--width,height = 768, 1024
cur_x = math.max(width,height)
cur_y = math.min(width,height)

print("运行环境 x轴"..cur_x.." y轴"..cur_y)
nine_pos = {
	{0,0},
	{cur_x/2,0},
	{cur_x,0},
	
	{0,cur_y/2},
	{cur_x/2,cur_y/2},
	{cur_x,cur_y/2},
	
	{0,cur_y},
	{cur_x/2,cur_y},
	{cur_x,cur_y}
}


--缩放比例计算
if (dep_width/dep_height) < (width / height) then
	sacale_rate = dep_x/cur_x
elseif (dep_width/dep_height) > (width / height) then
	sacale_rate = dep_y/cur_y
else
	sacale_rate = 1
end

print("当前缩放比例"..sacale_rate)

function returnpos(arcpos,array)
	return math.floor((array[1]-dep_nine_pos[arcpos][1]) / sacale_rate + nine_pos[arcpos][1]), math.floor((array[2]-dep_nine_pos[arcpos][2])/ sacale_rate  + nine_pos[arcpos][2])
end

recal_x, recal_y = returnpos(1,{9,157})
print(recal_x..":"..recal_y)