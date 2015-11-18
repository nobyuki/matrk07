require "smalruby"

cat1 = Character.new(costume: "costume1:cat1.png", x: 0, y: 126, angle: 0)
shot = Character.new(costume: "costume1:ball6.png", x: 0, y: 0, angle: 0)
item = Character.new(costume: ["costume1:ball1.png", "costume2:ball2.png", "costume3:ball3.png", "costume4:ball4.png"], costume_index: 3, x: 562, y: 140, angle: 0)
速度 = -10
加速度 = 0


cat1.on(:key_down, K_DOWN) do
  self.y += 20
end

cat1.on(:key_down, K_UP) do
  self.y += -20
end


shot.on(:start) do
  self.visible = false
end

shot.on(:key_down, K_SPACE) do
  go_to(cat1)
  self.visible = true
  loop do
    move(20)
    if reach_wall?
      break
    end
    if hit?(item)
      item.next_costume
      速度 = 5
      加速度 = 5
      break
    end
  end
  self.visible = false
end


item.on(:start) do
  loop do
    if 速度 > -10
      速度 = 速度 + 加速度
      加速度 = 加速度 - 1
    else
      速度 = -10
    end
    self.x += 速度
  end
end
