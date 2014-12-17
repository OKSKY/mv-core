require 'spec_helper'

require 'mv/core/validation/uniqueness'

describe Mv::Core::Validation::Uniqueness do
  describe "#initialize" do
    subject { described_class.new(message: :message, 
                                  index_name: :index_name, 
                                  on: :on, 
                                  create_trigger_name: :create_trigger_name, 
                                  update_trigger_name: :update_trigger_name, 
                                  allow_nil: :allow_nil, 
                                  allow_blank: :allow_blank, 
                                  as: :as) }

    its(:message) { is_expected.to eq(:message) }
    its(:index_name) { is_expected.to eq(:index_name) }
    its(:on) { is_expected.to eq(:on) }
    its(:create_trigger_name) { is_expected.to eq(:create_trigger_name) }
    its(:update_trigger_name) { is_expected.to eq(:update_trigger_name) }
    its(:allow_nil) { is_expected.to eq(:allow_nil) }
    its(:allow_blank) { is_expected.to eq(:allow_blank) }
    its(:as) { is_expected.to eq(:as) }
  end
end