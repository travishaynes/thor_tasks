require 'spec_helper'

describe Spec do
  it { should respond_to :controller }
  it { should respond_to :helper }
  it { should respond_to :model }
  it { should respond_to :request }
  it { should respond_to :routing }
  it { should respond_to :view }
end
