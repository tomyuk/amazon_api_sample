# -*- ruby -*-

namespace 'doc' do
  desc 'Generate docs of javascripts for the app'
  task 'js' do |t|
    sh 'yuidoc -c yuidoc.json app'
  end
end
