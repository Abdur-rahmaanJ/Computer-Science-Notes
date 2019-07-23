require 'yaml'

test_1 = ["this", "is", "an", ["embedded", "array"], 2, 3]
test_2 = ["level1", ["level2", ["level 3"]], 2, 3]

p test_1
puts YAML::dump(test_1)

p test_2
puts YAML::dump(test_2)

yml_obj = YAML::dump(test_1)

p YAML::load(yml_obj)