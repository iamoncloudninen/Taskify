class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.completed = false
    if params[:today_only] == "1"
      @task.deadline = Time.zone.now.end_of_day
    end
    if @task.save
      begin
        ai_message = generate_ai_message("created", @task)
      rescue StandardError => e
        ai_message = "AIメッセージの生成に失敗しました: #{e.message}"
      end
      ai_message = generate_ai_message("created", @task)
      flash[:notice] = "タスクを作成しました！#{ai_message}"
      redirect_to dashboard_show_path
    else
      flash[:alert] = "タスクの作成に失敗しました。内容を確認してください。"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    if @task.save
      flash[:notice] = "タスクを更新しました。"
      redirect_to dashboard_show_path(@task)
    else
      flash[:alert] = "タスクの更新に失敗しました。内容を確認してください。"
      render :edit
    end
  end

  def complete
    @task = Task.find(params[:id])
    if @task.update(completed: true, completed_at: Time.zone.now)
      begin
        ai_message = generate_ai_message("complete", @task)
      rescue StandardError => e
        ai_message = "AIメッセージの生成に失敗しました: #{e.message}"
      end
      flash[:notice] = "タスクを達成しました!#{ai_message}"
      redirect_to dashboard_show_path
    else
      flash[:notice] = "タスクの達成に失敗しました。内容を確認してください"
      redirect_to dashboard_show_path
    end
  end

  def incomplete
    @task = Task.find(params[:id])
    @task.update(completed: false, completed_at: nil)
    flash[:notice] = "タスクを未達成に戻しました。"
    redirect_to dashboard_show_path
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = "タスクを削除しました。"
      redirect_to dashboard_show_path
    end
  end

  private
  def task_params
    params.require(:task).permit(:content, :deadline, :priority, :image)
  end

  def generate_ai_message(event, task)
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    prompt = case event
             when "created"
               "新しいタスク「#{task.content}」が作成されました。ユーザーを励まして、このタスクを開始するモチベーションをシンプルなメッセージで提供してください。"
             when "complete"
               "タスク「#{task.content}」が完了しました！達成感を感じられるようなシンプルなメッセージを送り、次のタスクへのモチベーションを提供してください。"
             end
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "あなたは親切でポジティブなタスクコーチです。" },
          { role: "user", content: prompt }
        ]
      }
    )
    response.dig("choices", 0, "message", "content") || "AIメッセージ生成に失敗しました。"
  end
end
