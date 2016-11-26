@ShowBlog = React.createClass
  getInitialState: ->
    blog: @props.data.blog
    comments: @props.data.comments
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleEdit: (e) ->
    e.preventDefault()
    data =
      author: ReactDOM.findDOMNode(@refs.author).value
      content: ReactDOM.findDOMNode(@refs.content).value
    $.ajax
      method: 'PUT'
      url: "/blogs/#{ @state.blog.id }"
      dataType: 'JSON'
      data:
        blog: data
      success: (data) =>
        @setState edit: false
        @replaceState blog: data

  addComment: (comment) ->
    comments = React.addons.update(@state.comments, { $push: [comment] })
    @setState comments: comments

  deleteComment: (comment) ->
    index = @state.comments.indexOf comment
    comments = React.addons.update(@state.comments, { $splice: [[index, 1]] })
    @replaceState comments: comments, blog: @state.blog

  updateComment: (comment, data) ->
    index = @state.comments.indexOf comment
    comments = React.addons.update(@state.comments, { $splice: [[index, 1, data]] })
    @replaceState comments: comments, blog: @state.blog

  render: ->
    if @state.edit
      @blogForm()
    else
      @blogDisplay()

  blogDisplay: ->
    React.DOM.div
      className: 'jumbotron blogs'
      React.DOM.h1
        className: 'center'
        @state.blog.author
      React.DOM.p
        className: 'content center'
        @state.blog.content
      React.DOM.a
        className: 'btn btn-default'
        onClick: @handleToggle
        'Edit'
      React.DOM.a
        className: 'btn btn-default'
        onClick: @handleBackButtonPress
        'Back'
      React.DOM.div
        className: 'comments'
        React.DOM.h2
          className: 'title'
          'Comments List'
        React.DOM.div
          className: 'blogs-down-padding'
        React.createElement(CommentForm, { blog: @state.blog, handleNewComment: @addComment })
        React.DOM.div
          className: 'blogs-down-padding'
        if @state.comments.length
          React.DOM.table
            className: 'table table-bordered'
            React.DOM.thead null,
              React.DOM.tr null,
                React.DOM.th className: 'col-md-4 center', 'Content'
                React.DOM.th className: 'col-md-4 center', 'Actions'
            React.DOM.tbody null,
              for comment in @state.comments
                React.createElement Comment, key: comment.id, comment: comment, handleDeleteComment: @deleteComment, handleEditComment: @updateComment
        else
          React.DOM.h5
            className: 'no-comments'
            'This post has no comments yet.!'

  blogForm: ->
    React.DOM.div
      className: 'blogs blog-edit-form'
      React.DOM.input
        className: 'form-control'
        type: 'text'
        defaultValue: @state.blog.author
        ref: 'author'
      React.DOM.textarea
        className: 'form-control'
        type: 'text'
        defaultValue: @state.blog.content
        ref: 'content'
      React.DOM.a
        className: 'btn btn-success'
        onClick: @handleEdit
        'Update'
      React.DOM.a
        className: 'btn btn-default'
        onClick: @handleBackButtonPress
        'Back'

  handleBackButtonPress: ->
    ReactDOM.render(React.createElement(Blogs, null), document.getElementById('display_blog'))
