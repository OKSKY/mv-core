require 'spec_helper'

describe Mv::Core::ActiveRecord::SchemaDecorator do
  subject(:define) {
    ::ActiveRecord::Schema.define(version: 20150112161454) do
      create_table :table_name do |t|
        t.string :column_name
      end
    end
  }

  it "creates migration validators table" do
    expect{ define }.to change{::ActiveRecord::Base.connection.data_source_exists?(:migration_validators)}.from(false).to(true)
  end

  it "calls original method" do
    expect{ define }.to change{::ActiveRecord::Base.connection.data_source_exists?(:table_name)}.from(false).to(true)
  end

  it "executes migration" do
    expect(Mv::Core::Migration::Base).to receive(:execute)
    define
  end
end
