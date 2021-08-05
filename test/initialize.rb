require 'active_record'
require 'arel'
require './lib/arel-ext'

require 'minitest/pride'
require 'minitest/autorun'

ActiveRecord::Base.configurations = {
  'test' => {
    'adapter'  => 'mysql2',
    'host'     => 'localhost',
    'database' => 'arel_ext_test',
    'username' => 'arel_ext_tester',
    'password' => 'doro*he*d0r0',
    'pool'     => 1
  }
}
ActiveRecord::Base.establish_connection(:test)

Arel::Table.engine = ActiveRecord::Base

module Arel
  module Testing
    class Test < Minitest::Test
    end
  end
end
