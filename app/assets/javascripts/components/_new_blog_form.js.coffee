@BlogForm = React.createClass
  getInitialState: ->
    author: ''
    content: ''
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'author'
          name: 'author'
          value: @state.author
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'content'
          name: 'content'
          value: @state.content
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-success'
        disabled: !@valid()
        'Create Blog'
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.author && @state.content
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/blogs', { blog: @state }, (data) =>
      @props.handleNewBlog data
      @setState @getInitialState()
    , 'JSON'