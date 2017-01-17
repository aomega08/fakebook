require 'rails_helper'

describe RecipientsController do
  describe '#index' do
    context 'without a name parameter' do
      it 'is successful' do
        get :index
        expect(response).to be_successful
      end
    end

    context 'with a name parameter' do
      it 'searches for the recipient' do
        expect(Recipient).to receive(:find).with('john').and_return([])
        get :index, params: { name: 'john' }
      end

      context 'when the search has results' do
        before { allow(Recipient).to receive(:find).and_return(['john', 'jake', 'francesco']) }

        it 'renders the show template' do
          get :index, params: { name: 'john' }
          expect(response).to render_template(:show)
        end
      end

      context 'when the search has 0 results' do
        before { allow(Recipient).to receive(:find).and_return([]) }

        it 'sets a flash message' do
          get :index, params: { name: 'john' }
          expect(flash.now[:error]).to_not be_blank
        end
      end
    end
  end

  describe '#new' do
    it 'assigns a new recipient' do
      get :new
      expect(assigns(:recipient)).to be_a Recipient
    end

    it 'is successful' do
      get :new
      expect(response).to be_successful
    end
  end

  describe '#create' do
    context 'when the creation is successful' do
      before { allow_any_instance_of(Recipient).to receive(:save).and_return(true) }

      it 'redirects to the recipient details page' do
        post :create, params: { recipient: { name: 'Mario' } }
        expect(response).to redirect_to(recipients_path(name: 'Mario'))
      end
    end

    context 'when the creation fails' do
      before { allow_any_instance_of(Recipient).to receive(:save).and_return(false) }

      it 'assigns a recipient' do
        post :create, params: { recipient: { name: '' } }
        expect(assigns(:recipient)).to be_a Recipient
      end

      it 'renders the new template' do
        post :create, params: { recipient: { name: '' } }
        expect(response).to render_template(:new)
      end
    end
  end
end
