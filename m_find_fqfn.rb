def m_find_fqfn(p_active_record, p_fqfn = nil)
=begin
  a method to construct a fully qualified file name
  given an active record that is a file from the 
  Library model
=end
  # TODO: be sure that the initial value is a file
  # (isleaf is true)
  # TODO: error processing... what if a path can't 
  # be found?
  # TODO: Stop recursion if it gets "too" deep.
  if p_active_record.isroot
    if p_fqfn
      return p_active_record.name + "/" + p_fqfn
    else
      return p_active_record.name
    end
  else
    parentLibItem = Library.find(p_active_record.idofparent)
    if p_fqfn
      m_find_fqfn(parentLibItem, p_active_record.name + "/" + p_fqfn)
    else
      m_find_fqfn(parentLibItem, p_active_record.name)
    end
  end
end
