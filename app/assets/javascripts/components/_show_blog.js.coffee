@ShowBlog = React.createClass
  getInitialState: ->
    blog: @props.data
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