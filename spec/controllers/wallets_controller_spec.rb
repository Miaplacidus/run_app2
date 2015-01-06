require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe WalletsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Wallet. As you add validations to Wallet, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WalletsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    xit "assigns all wallets as @wallets" do
      wallet = Wallet.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:wallets)).to eq([wallet])
    end
  end

  describe "GET show" do
    xit "assigns the requested wallet as @wallet" do
      wallet = Wallet.create! valid_attributes
      get :show, {:id => wallet.to_param}, valid_session
      expect(assigns(:wallet)).to eq(wallet)
    end
  end

  describe "GET new" do
    xit "assigns a new wallet as @wallet" do
      get :new, {}, valid_session
      expect(assigns(:wallet)).to be_a_new(Wallet)
    end
  end

  describe "GET edit" do
    xit "assigns the requested wallet as @wallet" do
      wallet = Wallet.create! valid_attributes
      get :edit, {:id => wallet.to_param}, valid_session
      expect(assigns(:wallet)).to eq(wallet)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      xit "creates a new Wallet" do
        expect {
          post :create, {:wallet => valid_attributes}, valid_session
        }.to change(Wallet, :count).by(1)
      end

      xit "assigns a newly created wallet as @wallet" do
        post :create, {:wallet => valid_attributes}, valid_session
        expect(assigns(:wallet)).to be_a(Wallet)
        expect(assigns(:wallet)).to be_persisted
      end

      xit "redirects to the created wallet" do
        post :create, {:wallet => valid_attributes}, valid_session
        expect(response).to redirect_to(Wallet.last)
      end
    end

    describe "with invalid params" do
      xit "assigns a newly created but unsaved wallet as @wallet" do
        post :create, {:wallet => invalid_attributes}, valid_session
        expect(assigns(:wallet)).to be_a_new(Wallet)
      end

      xit "re-renders the 'new' template" do
        post :create, {:wallet => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      xit "updates the requested wallet" do
        wallet = Wallet.create! valid_attributes
        put :update, {:id => wallet.to_param, :wallet => new_attributes}, valid_session
        wallet.reload
        skip("Add assertions for updated state")
      end

      xit "assigns the requested wallet as @wallet" do
        wallet = Wallet.create! valid_attributes
        put :update, {:id => wallet.to_param, :wallet => valid_attributes}, valid_session
        expect(assigns(:wallet)).to eq(wallet)
      end

      xit "redirects to the wallet" do
        wallet = Wallet.create! valid_attributes
        put :update, {:id => wallet.to_param, :wallet => valid_attributes}, valid_session
        expect(response).to redirect_to(wallet)
      end
    end

    describe "with invalid params" do
      xit "assigns the wallet as @wallet" do
        wallet = Wallet.create! valid_attributes
        put :update, {:id => wallet.to_param, :wallet => invalid_attributes}, valid_session
        expect(assigns(:wallet)).to eq(wallet)
      end

      xit "re-renders the 'edit' template" do
        wallet = Wallet.create! valid_attributes
        put :update, {:id => wallet.to_param, :wallet => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    xit "destroys the requested wallet" do
      wallet = Wallet.create! valid_attributes
      expect {
        delete :destroy, {:id => wallet.to_param}, valid_session
      }.to change(Wallet, :count).by(-1)
    end

    xit "redirects to the wallets list" do
      wallet = Wallet.create! valid_attributes
      delete :destroy, {:id => wallet.to_param}, valid_session
      expect(response).to redirect_to(wallets_url)
    end
  end

end
