# Este repositório contém: 



1. Um aplicativo de Lista de tarefas desenvolvido com flutter. Foi melhorado com duas novas funcionalidades: um cronômetro comum, que inicia um contador em zero e encerra assim que o usuário desejar, já com a contagem  formatada no padrão brasileiro (00 : 00 : 00) de horas, minutos e segundos; e um outro cronômetro com a mesma formatação mas com uma contagem reversa a partir de um tempo pré definido até que o contador alcance o zero. Funcionalidade de cronômetro reverso está sendo melhorada, em breve será atualizada com função de definição do horário de onde partirá a contagem. 




#  Neste projeto foram usados os packages externos:



1. **Intl:** usado para a formatação de data e horário das tarefas publicadas.
1. **flutter_slidable: ˆ0.6.0**:  usado para adicionar os botões em formato de slide com as funcionalidades de deletar, temporizar e cronometrar cada tarefa adicionada pelo usuário na lista
1. **shared_preferences:*ˆ2.0.15**: usado para salvar as tarefas publicadas em um repositório e retorná-las quando o aplicativo for encerrado e aberto novamente. 



# Na lib deste projeto os repositórios foram organizados em:



1. **models:** onde foi criado o objeto TaskModel com o modelo de armazenamento das tarefas que contém o atributo **datetime** para o armazenamento do horário local em que a tarefa foi adicionada, e o atributo **title** para o armazenamento do conteúdo com a descrição da tarefa em si, além dos métodos fromJson() e toJson() que convertem, respectivamente, o objeto armazenado em datetime e json para ser guardado no repositório . 
2. **pages:** repositório criado para armazenar os widgets com as páginas do aplicativo que, nesta versão, contém apenas uma única página (homepage.dart) com o widget **Homepage()** onde todas as funcionalidades são executadas.
3. **repositories:** repositório criado para armazenar o objeto **TaskRepository**, criado com o SharedPreferences para armazenar os dados inputados das tarefas quando o aplicativo é encerrado e retorná-los quando for aberto novamente.
4. **widgets**: aqui está armazenado o arquivo taskcontainer.dart com o widget **TaskContainer** que da o modelo visual para cada tarefa publicada. 



# Neste projeto você encontrará os seguintes widgets:



1. MyApp( ): widget básico retorna o MaterialApp com o widget principal Homepage() abaixo. 
2. Homepage( ): widget principal, com todas as variáveis, estados e funções que fazem o aplicativo funcionar. 
3. TaskModel( ): modelo de objeto criado para guardar as tarefas adicionadas com os atributos datetime (guarda o horário local em que a tarefa foi publicada) e title (guarda a string com a descrição da tarefa)
4. TaskContainer( ): renderiza o TaskModel em um Container que mostra o o horário e a descrição de cada tarefa publicada.
5. TaskRepository( ): objeto criado com SharedPreferences para salvar os dados inputados quando o aplicativo for encerrado e retorná-los qunado for reaberto.






# Neste projeto você encontrará as seguintes funções:



​		abaixo funções usadas nos botões de adição e deleção de tarefas. 




1. **addTaskIfNotEmptyField():** a função verifica se o campo de texto da tarefa adicionada não está vazio e caso não esteja adiciona a tarefa na lista de tarefas adicionadas que será exibida na tela. Se não houver nenhum texto no campo, a função retorna uma mensagem de erro dentro da variável errorText informando que o texto não pode ser vazio.  

2. **deleteTask(TaskModel task):** função faz a deleção da tarefa recebida no parâmetro, mas salva a tarefa deletada e abre um SnackBar com um botão "Desfazer" para reverter a ação em um período de 5 segundos. 

3. **deleteAllTasks():** função deleta todas as tarefas da lista, mas antes abre um AlertDialog requisitando uma confirmação da ação. Caso o usuário clique em Cancelar, o diálogo é encerrado e a ação não será concluída, em caso contrário, quando o usuário clica em "Limpar tudo", todas as tarefas são deletadas da lista. 

   

   abaixo funções usadas no cronômetro

   

4. **showTimerDialog:** mosta um AlertDialog com 1 cronômetro e 4 botões que ativam as próximas funções: **Fechar**, **Zerar**, **Parar**, **Iniciar**

5. **startTimer:** inicia a contagem do cronômetro quando o usuário clica no botão "Iniciar"

6. **resetTimer:** Zera o cronômetro quando o usuário clica no botão "Zerar"

7. **stopTimer:** Para a contagem do cronômetro 

8. **quitTimerDialogAndResetTimer:** Fecha o cronômetro e zera a contagem

   

   abaixo funções do cronômetro reverso

   

9. **showReverseTimerDialog:** mosta um AlertDialog com 1 cronômetro invertido e 4 botões que ativam as próximas funções: **Fechar**, **Zerar**, **Parar**,**Iniciar**

10. **startReverseTimer:** inicia a contagem do cronômetro invertido quando o usuário clica no botão "Iniciar", quando a contagem alcança 00 : 00 : 00 a contagem é finalizada. Função usada dentro da função acima ShowReverseTimerDialog

11. **resetReverseTimer:** Zera o cronômetro quando o usuário clica no botão "Zerar". Função usada dentro da função ShowReverseTimerDialog

12. **stopReverseTimer:** Para a contagem do cronômetro. Função usada dentro da função ShowReverseTimerDialog

1. **quiReverseTimerDialogAndResetTimer:** Fecha o cronômetro e zera a contagem.Função usada dentro da função ShowReverseTimerDialog
