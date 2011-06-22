require 'spec_helper'

describe Mongo do
  it { should respond_to :start }
  it { should respond_to :restart }
  it { should respond_to :stop }
  it { should respond_to :repair }
end
