-- Appends all elements from `t2` to `t1`.
function table.merge_lists(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end

  return t1
end
