require 'rails_helper'

describe PaymentsController do
  describe '#index' do
    it 'assigns an array of payments' do
      stub_payments = [Payment.new, Payment.new, Payment.new]
      allow(Payment).to receive(:all).and_return(stub_payments)

      get :index
      expect(assigns(:payments)).to eq stub_payments
    end

    it 'is successful' do
      allow(Payment).to receive(:all)
      get :index
      expect(response).to be_successful
    end
  end

  describe '#new' do
    it 'assigns a new payment' do
      get :new
      expect(assigns(:payment)).to be_a Payment
    end

    it 'is successful' do
      get :new
      expect(response).to be_successful
    end
  end

  describe '#create' do
    context 'when the creation is successful' do
      before { allow_any_instance_of(Payment).to receive(:save).and_return(true) }

      it 'redirects to the home page' do
        post :create, params: { payment: { amount: 10 } }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the creation fails' do
      before { allow_any_instance_of(Payment).to receive(:save).and_return(false) }

      it 'assigns a payment' do
        post :create, params: { payment: { amount: 10 } }
        expect(assigns(:payment)).to be_a Payment
      end

      it 'renders the new template' do
        post :create, params: { payment: { amount: 10 } }
        expect(response).to render_template(:new)
      end
    end
  end
end
