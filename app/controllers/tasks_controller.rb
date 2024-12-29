class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :complete, :incomplete, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    set_deadline_for_today_only if params[:today_only] == "1"

    if @task.save
      flash[:notice] = "タスクを作成しました！#{generate_ai_message('created', @task)}"
      redirect_to dashboard_show_path
    else
      flash[:alert] = "タスクの作成に失敗しました。内容を確認してください。"
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:notice] = "タスクを更新しました。"
      redirect_to dashboard_show_path
    else
      flash[:alert] = "タスクの更新に失敗しました。内容を確認してください。"
      render :edit
    end
  end

  def complete
    if @task.update(completed: true, completed_at: Time.zone.now)
      flash[:notice] = "タスクを達成しました!#{generate_ai_message('complete', @task)}"
    else
      flash[:alert] = "タスクの達成に失敗しました。"
    end
    redirect_to dashboard_show_path
  end

  def incomplete
    @task.update(completed: false, completed_at: nil)
    flash[:notice] = "タスクを未達成に戻しました。"
    redirect_to dashboard_show_path
  end

  def destroy
    @task.destroy
    flash[:notice] = "タスクを削除しました。"
    redirect_to dashboard_show_path
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :deadline, :priority, :image)
  end

  def set_deadline_for_today_only
    @task.deadline = Time.zone.now.end_of_day
  end

  def generate_ai_message(event, task)
    prompt = case event
             when "created"
               "新しいタスク「#{task.content}」が作成されました。ユーザーを励まして、このタスクを開始するモチベーションをシンプルなメッセージで提供してください。"
             when "complete"
               "タスク「#{task.content}」が完了しました！達成感を感じられるようなシンプルなメッセージを送り、次のタスクへのモチベーションを提供してください。"
             end

    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
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
