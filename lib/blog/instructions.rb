module Blog
  module Instructions

    def self.instructions_post
      '<div id="instructions" class="post">
         <h3 class="name"> Instructions </h3>
         <h4 class="date"> The date goes here </h4>
         <p class="content"> Blog posts will be added and visualized in this section. 
         <br />To add a new post Select the' + "'New'" + 'button
         <br />To read, edit or delete a post click on the post name.
         <br />This post will dissapear when you add a new one</p>
       </div> <!--#post-->'
    end

    def self.instructions_sidebar
      '<li><a href="#instructions"> Instructions </a></li>
       <p> As you add posts <br />the link to them <br />will appear here</p>'
    end
  end
end
