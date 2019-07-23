BottomConstantOne = "My BottomConstant"

class BotClass
  BotConstantTwo = "its second"
  @@bot1_class_var =   221

  def use_bottom_it(no)
    p [@@bot1_class_var,  no,  "answer"]
  end

  def use_bottom_inst_var
    puts @inst_var = "hi I am bottom instance\n\n"
  end

  def use_class_var_from_top
    p @@top_class_var
  end
end

p "This is coming whe we load in Bottom.rb"
p   BottomConstantOne
p   BotClass::BotConstantTwo


bot_obj = BotClass.new
bot_obj.use_bottom_it(3)
bot_obj.use_bottom_inst_var
#bot_obj.use_class_var_from_top         uninitialized class variable @@top_class_var in BotClass (NameError)
  #new_obj.use_it(5)                      undefined local variable or method `new_obj' for main:Object (NameError)
