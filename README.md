```log
:article => {
  :belongs_to => [
    [0] :user
  ],
  :has_many => [
    [0] :review,
    [1] :comment,
    [2] :technology_assignment
  ],
  :attributes => [
    [0] {
      :name => "title:string",
      :flags => [
        [0] :required,
        [1] :search
      ]
    },
    [1] {
      :name => "content:text",
      :flags => [
        [0] :required
      ]
    }
  ]
}
```