require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }
  let(:task) { create(:task, user: user) }

  describe 'GET /api/v1/users/:user_id/tasks' do
    context 'authenticated' do
      it 'returns all tasks and 200' do
        task
        get "/api/v1/users/#{user.id}/tasks", headers: headers
        expect(response).to have_http_status(:ok)
        expect(json).to have_key('tasks')
        expect(json).to have_key('meta')
        expect(json['tasks'].length).to eq(1)
      end
    end

    context 'unauthenticated' do
      it 'returns 401' do
        get "/api/v1/users/#{user.id}/tasks"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'pagination' do
      it 'returns paginated results' do
        create_list(:task, 10, user: user)
        get "/api/v1/users/#{user.id}/tasks", params: { page: 1, per_page: 5 }, headers: headers
        json = JSON.parse(response.body)
        expect(json['tasks'].length).to eq(5)
        expect(json['meta']['per_page']).to eq(5)
        expect(json['meta']['total_count']).to eq(10)
      end
    end

    context 'filtering' do
      it 'returns the filtered results when filtered by status' do
        create(:task, user: user, status: :pending)
        create(:task, user: user, status: :completed)
        get "/api/v1/users/#{user.id}/tasks", params: {status: pending}, headers: headers
        json = JSON.parse(response.body)
        expect(json['tasks'].length).to eq(1)
        expect(json['tasks'].first['status']).to eq('pending')
      end

      it 'returns the filtered results when filtered by priority' do
        create(:task, user: user, priority: 'low')
        create(:task, user: user, priority: 'high')
        get "/api/v1/users/#{user.id}/tasks", params: {priority: 'high'}, headers: headers
        json = JSON.parse(response.body)
        expect(json['tasks'].length).to eq(1)
        expect(json['tasks'].first['priority']).to eq('high')
      end

    end
  end

  describe 'POST /api/v1/users/:user_id/tasks' do
    context 'authenticated' do
      it 'creates a task and returns 201' do
        post "/api/v1/users/#{user.id}/tasks", params: {
          task: {
            title: 'New Task',
            description: 'Description',
            status: 'pending',
            priority: 'high',
            due_date: 1.year.from_now
          }
        }, headers: headers
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['title']).to eq('New Task')
      end

      it 'returns 422 with invalid params' do
        post "/api/v1/users/#{user.id}/tasks", params: {
          task: { title: nil, status: 'pending', priority: 'high' }
        }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end

    context 'unauthenticated' do
      it 'returns 401' do
        post "/api/v1/users/#{user.id}/tasks", params: {
          task: { title: 'New Task' }
        }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/users/:user_id/tasks/:id' do
    context 'authenticated' do
      it 'returns the task and 200' do
        get "/api/v1/users/#{user.id}/tasks/#{task.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['title']).to eq(task.title)
      end

      it 'returns 404 for wrong id' do
        get "/api/v1/users/#{user.id}/tasks/99999", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'unauthenticated' do
      it 'returns 401' do
        get "/api/v1/users/#{user.id}/tasks/#{task.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/v1/users/:user_id/tasks/:id' do
    context 'authenticated' do
      it 'updates the task and returns 200' do
        put "/api/v1/users/#{user.id}/tasks/#{task.id}", params: {
          task: { title: 'Updated Task' }
        }, headers: headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['title']).to eq('Updated Task')
      end

      it 'returns 422 with invalid params' do
        put "/api/v1/users/#{user.id}/tasks/#{task.id}", params: {
          task: { title: nil }
        }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns 404 for wrong id' do
        put "/api/v1/users/#{user.id}/tasks/99999", params: {
          task: { title: 'test' }
        }, headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'unauthenticated' do
      it 'returns 401' do
        put "/api/v1/users/#{user.id}/tasks/#{task.id}", params: {
          task: { title: 'test' }
        }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/users/:user_id/tasks/:id' do
    context 'authenticated' do
      it 'deletes the task and returns 200' do
        delete "/api/v1/users/#{user.id}/tasks/#{task.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Task deleted!')
      end

      it 'returns 404 for wrong id' do
        delete "/api/v1/users/#{user.id}/tasks/99999", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'unauthenticated' do
      it 'returns 401' do
        delete "/api/v1/users/#{user.id}/tasks/#{task.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end