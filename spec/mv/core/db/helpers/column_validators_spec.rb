require 'spec_helper'

require 'mv/core/services/create_migration_validators_table'
require 'mv/core/db/migration_validator'
require 'mv/core/db/helpers/column_validators'

describe Mv::Core::Db::Helpers::ColumnValidators do
  let(:instance) do
    Class.new do
      include Mv::Core::Db::Helpers::ColumnValidators

      def initialize
        self.table_name = :table_name
        self.column_name = :column_name
      end
    end.new
  end

  before do
    Mv::Core::Services::CreateMigrationValidatorsTable.new.execute
  end

  let(:migration_validator) { build(:migration_validator) }

  describe "#create_column_validator" do
     describe "with full options hash" do
      subject(:create_column_validator){ 
        instance.create_column_validator(:uniqueness, 
                                         { as: :trigger}) 
      }
      
      it "creates new migration validator" do
        expect{ subject }.to change(Mv::Core::Db::MigrationValidator, :count).by(1)
      end

      describe "newly created validator" do
        subject(:validator) do
          create_column_validator
          Mv::Core::Db::MigrationValidator.last
        end

        its(:table_name) { is_expected.to eq('table_name') }
        its(:column_name) { is_expected.to eq('column_name') }
        its(:validation_type) { is_expected.to eq('uniqueness') }
        its(:options) { is_expected.to eq(as: :trigger) }
      end
    end

    describe "with true as create validator instruction" do
      subject(:create_column_validator){ 
        instance.create_column_validator(:uniqueness, true) 
      }
      
      it "creates new migration validator" do
        expect{ subject }.to change(Mv::Core::Db::MigrationValidator, :count).by(1)
      end

      describe "newly created validator" do
        subject(:validator) do
          create_column_validator
          Mv::Core::Db::MigrationValidator.last
        end

        its(:options) { is_expected.to eq({}) }
      end
    end

    describe "with simplified option as create validator instruction" do
      subject(:create_column_validator){ 
        instance.create_column_validator(:length, 1..3) 
      }
      
      it "creates new migration validator" do
        expect{ subject }.to change(Mv::Core::Db::MigrationValidator, :count).by(1)
      end

      describe "newly created validator" do
        subject(:validator) do
          create_column_validator
          Mv::Core::Db::MigrationValidator.last
        end

        its(:options) { is_expected.to eq(in: 1..3) }
      end
    end

    describe "with false as delete validator instruction" do
      subject(:create_column_validator){ instance.create_column_validator(:uniqueness, false) }

      it "raised an error" do
        expect{ create_column_validator }.to raise_error(Mv::Core::Error)
      end
    end

    describe "when such validator exists already" do
      let!(:validator) do
        create(:migration_validator, validation_type: :uniqueness, options: { as: :trigger })
      end

      subject(:create_column_validator){ instance.create_column_validator(:uniqueness, { as: :index }) }

      it "updates options of the existing validator" do
        expect{ create_column_validator }.to change{validator.reload.options}.from(as: :trigger).to(as: :index)
      end
    end
  end

  describe "#update_column_validator" do
    describe 'when validator is to be removed' do
      before { migration_validator.save! }

      subject(:update_column_validator) { instance.update_column_validator(:uniqueness, false) }

      it "should remove existing validator" do
        expect{ update_column_validator }.to change(Mv::Core::Db::MigrationValidator, :count).by(-1)
      end
    end

    describe 'when validator exists' do
      before { migration_validator.save! }

      subject(:update_column_validator) { instance.update_column_validator(:uniqueness, { as: :index }) }

      it "updates existing validator with passed options" do
        expect{ update_column_validator }.to change{ migration_validator.reload.options }.from(as: :trigger).to(as: :index)
      end
    end

    describe 'when validator does not exist' do
      subject(:update_column_validator) { instance.update_column_validator(:uniqueness, true) }

      it "should create new validator" do
        expect{ update_column_validator }.to change(Mv::Core::Db::MigrationValidator, :count).by(1)
      end

      describe "newly created validator" do
        subject(:validator) do
          update_column_validator
          Mv::Core::Db::MigrationValidator.last
        end

        its(:table_name) { is_expected.to eq('table_name') }
        its(:column_name) { is_expected.to eq('column_name') }
        its(:validation_type) { is_expected.to eq('uniqueness') }
        its(:options) { is_expected.to eq({}) }
      end
    end
  end

  describe "#delete_column_validator" do
    before { migration_validator.save! }

    describe "when validator exists" do
      subject { instance.delete_column_validator }

      it { is_expected.to be_truthy }
      
      it "removes validator" do
        expect{ subject }.to change(Mv::Core::Db::MigrationValidator, :count).by(-1)
      end
    end

    describe "when validator does not exist" do
      subject { instance.delete_column_validator }

      before do
        migration_validator.update_attributes(column_name: :column_name_1)
      end

      it { is_expected.to be_falsey }
      
      it "does nothing" do
        expect{ subject }.not_to change(Mv::Core::Db::MigrationValidator, :count)
      end
    end
  end 

  describe "#rename_column" do
    before { migration_validator.save! }

    subject(:rename_column) { instance.rename_column(:column_name_1) }

    it "should change validator column name" do
      expect { rename_column }.to change{ migration_validator.reload.column_name }.from('column_name')
                                                                            .to('column_name_1')
      rename_column
    end
  end
end