require_relative 'bottom'

ConstantOne = "My Constant One"

class Newish
  ConstantTwo = "its second"
  @@top_class_var =   22

  def use_it(no)
    p @@top_class_var + no
  end

  def use_inst_var
    @inst_var = "hi I am instance\n\n"
    puts @inst_var
  end
end

p   ConstantOne
#p   ConstantTwo              uninitialized constant ConstantTwo (NameError)
p   Newish::ConstantTwo
#p   Newish::@@top_class_var   syntax error, unexpected tCVAR, expecting '(' (SyntaxError)

new_obj = Newish.new
new_obj.use_it(3)
new_obj.use_inst_var


p "This is coming from calls in topone.rb"
p   BottomConstantOne
p   BotClass::BotConstantTwo

bot_obj2 = BotClass.new
bot_obj2.use_bottom_it(5)
bot_obj2.use_bottom_inst_var


