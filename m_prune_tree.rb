def m_prune_tree (p_id, p_orig_id, p_indent_spaces=5)
 
  Library.where(idofparent: p_id).find_each do |rec_library|
    m_prune_tree(rec_library.id, p_orig_id, p_indent_spaces+5) unless rec_library.isleaf
    m_log('m_prune_tree','Info', ''.rjust(p_indent_spaces, ' ')+rec_library.name)
    Library.delete(rec_library.id)
  end
  
  if p_id == p_orig_id
    m_log('m_prune_tree','Info', p_id.to_s)
    Library.delete(p_id)
  end
  
end
