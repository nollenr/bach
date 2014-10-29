def m_prune_tree (p_id, p_orig_id, p_indent_spaces=5, p_log_run=false)
  
  v_process_name = 'prune_tree'
  m_setup_logging(v_process_name)
 
  Library.where(idofparent: p_id).find_each do |rec_library|
    m_prune_tree(rec_library.id, p_orig_id, p_indent_spaces+5) unless rec_library.isleaf
    m_log(v_process_name,'Info', ''.rjust(p_indent_spaces, ' ')+rec_library.name) if p_log_run
    Library.delete(rec_library.id)
  end
  
  if p_id == p_orig_id
    m_log(v_process_name,'Info', p_id.to_s) if p_log_run
    Library.delete(p_id)
  end
  
end
