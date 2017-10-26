# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "factory_girl"
require "yard"

require "justimmo_client"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)
YARD::Rake::YardocTask.new(:doc)

task default: :test

task test: %i[spec rubocop]

desc "Verify validity of FactoryGirl factories"
task :factory_lint do
  FactoryGirl.find_definitions
  FactoryGirl.lint
end
