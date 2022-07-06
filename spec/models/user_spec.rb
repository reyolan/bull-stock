require 'rails_helper'
include FactoryBot::Syntax::Methods
RSpec.describe User, type: :model do         
  context 'admin sign in' do  
    it 'cannot have comments' do   
      expect { Post.create.comments.create! }.to raise_error(ActiveRecord::RecordInvalid)  # test code
    end
  end
end
