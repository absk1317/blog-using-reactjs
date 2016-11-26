@Blog = React.createClass
  getInitialState: ->
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
      url: "/blogs/#{ @props.blog.id }"
      dataType: 'JSON'
      data:
        blog: data
      success: (data) =>
        @setState edit: false
        @props.handleEditBlog @props.blog, data

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/blogs/#{ @props.blog.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteBlog @props.blog

  render: ->
    if @state.edit
      @blogForm()
    else
      @blogRow()

  blogRow: ->
    React.DOM.tr null,
      React.DOM.td className: 'col-md-4 center', @props.blog.author
      React.DOM.td className: 'col-md-4 center', @props.blog.content
      React.DOM.td className: 'col-md-4 center',
        React.DOM.a
          className: 'btn btn-success'
          onClick: @renderBlog
          'Show'
        React.DOM.a
          className: 'btn btn-warning'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'

  blogForm: ->
    React.DOM.tr null,
      React.DOM.td className: 'col-md-4 center',
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.blog.author
          ref: 'author'
      React.DOM.td className: 'col-md-4 center',
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.blog.content
          ref: 'content'
      React.DOM.td className: 'col-md-4 center',
        React.DOM.a
          className: 'btn btn-success'
          onClick: @renderBlog
          'Show'
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'

  renderBlog: ->
    $.ajax
      type: 'GET'
      url: '/blogs/' + @props.blog.id
      success: (data) ->
        ReactDOM.render(React.createElement(ShowBlog, {data: data}) , document.getElementById('display_blog') )
    return