require 'spec_helper'

require 'mv/core/validation/uniqueness'

describe Mv::Core::Validation::Uniqueness do
  def instance(opts = {})
    table_name = opts.with_indifferent_access.delete(:table_name) || :table_name
    column_name = opts.with_indifferent_access.delete(:column_name) || :column_name
    described_class.new(table_name, column_name,
                        {message: :message,
                        # index_name: :index_name,
                        on: :save,
                        create_trigger_name: :create_trigger_name,
                        update_trigger_name: :update_trigger_name,
                        allow_nil: true,
                        allow_blank: true,
                        as: :trigger}.with_indifferent_access.merge(opts))
  end

  subject { instance }

  describe "#initialize" do
    describe "by default" do
      its(:table_name) { is_expected.to eq(:table_name) }
      its(:column_name) { is_expected.to eq(:column_name) }
      its(:message) { is_expected.to eq(:message) }
      its(:on) { is_expected.to eq(:save) }
      its(:create_trigger_name) { is_expected.to eq(:create_trigger_name) }
      its(:update_trigger_name) { is_expected.to eq(:update_trigger_name) }
      its(:allow_nil) { is_expected.to be_truthy }
      its(:allow_blank) { is_expected.to be_truthy }
      its(:as) { is_expected.to eq(:trigger) }

      describe ":index_name" do
        subject { instance(on: nil, update_trigger_name: nil, create_trigger_name: nil, index_name: :index_name, as: :index) }

        its(:index_name) { is_expected.to eq(:index_name) }
      end
    end

    describe "when simplification provided" do
      subject { described_class.new(:table_name, :column_name, true) }

      its(:options) { is_expected.to eq({}) }
    end
  end

  describe "#<==>" do
    it { is_expected.to eq(instance) }
    it { is_expected.to eq(instance({'table_name' => 'table_name',
                                     'column_name' => 'column_name',
                                    'message' => 'message',
                                    'on' => 'save',
                                    'create_trigger_name' => 'create_trigger_name',
                                    'update_trigger_name' => 'update_trigger_name',
                                    'allow_nil' => true,
                                    'allow_blank' => true,
                                    'as' => 'trigger' } )) }

    it { is_expected.not_to eq(instance(table_name: 'table_name_1')) }
    it { is_expected.not_to eq(instance(column_name: 'column_name_1')) }
    it { is_expected.not_to eq(instance(message: 'some_other_message')) }
    it { is_expected.not_to eq(instance(on: 'create')) }
    it { is_expected.not_to eq(instance(create_trigger_name: 'some_other_create_trigger_name')) }
    it { is_expected.not_to eq(instance(update_trigger_name: 'some_other_update_trigger_name')) }
    it { is_expected.not_to eq(instance(allow_nil: false)) }
    it { is_expected.not_to eq(instance(allow_blank: false)) }
    it { is_expected.not_to eq(instance(as: :index)) }

    describe ":index_name" do
      subject { instance(index_name: :index_name, as: :index) }

      it { is_expected.to eq(instance(as: :index, 'index_name' => 'index_name')) }
      it { is_expected.not_to eq(instance(as: :index, 'index_name' => 'index_name_1')) }
    end
  end

  describe "default values" do
    describe ":allow_nil" do
      subject { instance(allow_nil: nil) }

      its(:allow_nil) { is_expected.to be_falsey }
    end

    describe ":allow_blank" do
      subject { instance(allow_blank: nil) }

      its(:allow_blank) { is_expected.to be_falsey }
    end

    describe ":message" do
      subject { instance(message: nil) }

      its(:message) { is_expected.to eq('is not unique') }
      its(:full_message) { is_expected.to eq('column_name is not unique') }
    end

    describe ":on" do
      describe "when :as == :trigger" do
        subject { instance(on: nil, as: :trigger) }

        its(:on) { is_expected.to eq(:save) }
      end

      describe "when :as == :index" do
        subject { instance(on: nil, as: :index) }

        its(:on) { is_expected.to be_nil }
      end
    end

    describe ":as" do
      subject { instance(as: nil) }

      its(:as) { is_expected.to eq(:index) }
    end

    describe ":create_trigger_name" do
      describe "when :as == :trigger" do
        subject { instance(create_trigger_name: nil, as: :trigger) }

        its(:create_trigger_name) { is_expected.to eq('trg_mv_table_name_ins') }
      end

      describe "when :as == :index" do
        subject { instance(create_trigger_name: nil, as: :index) }

        its(:create_trigger_name) { is_expected.to be_nil }
      end

      describe "when :on == :update" do
        subject { instance(create_trigger_name: nil, on: :update) }

        its(:create_trigger_name) { is_expected.to be_nil }
      end
    end

    describe ":update_trigger_name" do
      describe "when :as == :trigger" do
        subject { instance(update_trigger_name: nil, as: :trigger) }

        its(:update_trigger_name) { is_expected.to eq('trg_mv_table_name_upd') }
      end

      describe "when :as == :index" do
        subject { instance(update_trigger_name: nil, as: :index) }

        its(:update_trigger_name) { is_expected.to be_nil }
      end

      describe "when :on == :create" do
        subject { instance(update_trigger_name: nil, on: :create) }

        its(:update_trigger_name) { is_expected.to be_nil }
      end
    end

    describe ":index_name" do
      describe "when :as == :trigger" do
        subject { instance(index_name: nil, as: :trigger) }

        its(:index_name) { is_expected.to be_nil }
      end

      describe "when :as == :index" do
        subject { instance(index_name: nil, as: :index) }

        its(:index_name) { is_expected.to eq('idx_mv_table_name_column_name_uniq') }
      end
    end
  end

  describe "validation" do
    it { is_expected.to be_valid }

    describe ":create_trigger_name" do
      describe "when :as == :index" do
        subject { instance(create_trigger_name: :trigger_name, update_trigger_name: nil, as: :index) }

        it { is_expected.to be_invalid }
      end

      describe "when :on == :update" do
        subject { instance(create_trigger_name: :trigger_name, update_trigger_name: nil, on: :update) }

        it { is_expected.to be_invalid }
      end
    end

    describe ":update_trigger_name" do
      describe "when :as == :index" do
        subject { instance(update_trigger_name: :trigger_name, create_trigger_name: nil, as: :index) }

        it { is_expected.to be_invalid }
      end

      describe "when :on == :create" do
        subject { instance(update_trigger_name: :trigger_name, create_trigger_name: nil, on: :create) }

        it { is_expected.to be_invalid }
      end
    end

    describe ":index_name" do
      describe "when :as == :trigger" do
        subject { instance(update_trigger_name: :nil, create_trigger_name: nil, index_name: :index_name, as: :trigger) }

        it { is_expected.to be_invalid }
      end

      describe "when :as == :index" do
        subject { instance(on: nil, update_trigger_name: nil, create_trigger_name: nil, index_name: :index_name, as: :index) }

        it { is_expected.to be_valid }
      end
    end


    describe ":on" do
      describe "when :on == :save" do
        subject { instance(on: :save) }

        it { is_expected.to be_valid }
      end

      describe "when :on == :update" do
        subject { instance(on: :update, create_trigger_name: nil) }

        it { is_expected.to be_valid }
      end

      describe "when :on == :create" do
        subject { instance(on: :create, update_trigger_name: nil) }

        it { is_expected.to be_valid }
      end

      describe "when :on == :invalid_event" do
        subject { instance(on: :invalid_event) }

        it { is_expected.to be_invalid }
      end

      describe "when :as == :index" do
        subject { instance(on: :nil, as: :index, create_trigger_name: nil, update_trigger_name: nil) }

        it { is_expected.to be_invalid }
      end
    end

    describe ":allow_nil" do
      [true, false].each do |value|
        describe "when :allow_nil == #{value}" do
          subject { instance(allow_nil: value) }

          it { is_expected.to be_valid }
        end
      end

      describe "when :allow_nil == :non_boolean_value" do
        subject { instance(allow_nil: :non_boolean_value) }

        it { is_expected.to be_invalid }
      end
    end

    describe ":allow_blank" do
      [true, false].each do |value|
        describe "when :allow_blank == #{value}" do
          subject { instance(allow_blank: value) }

          it { is_expected.to be_valid }
        end
      end

      describe "when :allow_blank == :non_boolean_value" do
        subject { instance(allow_blank: :non_boolean_value) }

        it { is_expected.to be_invalid }
      end
    end

    describe ":as" do
      describe "when :as == :index" do
        subject { instance(as: :index, create_trigger_name: nil, update_trigger_name: nil, on: nil) }

        it { is_expected.to be_valid }
      end

      describe "when :as == :invalid_constraint_type" do
        subject { instance(as: :invalid_constraint_type, create_trigger_name: nil, update_trigger_name: nil) }

        it { is_expected.to be_invalid }
      end
    end
  end
end
