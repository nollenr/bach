def m_crosscheck_itunes_cleanup
  v_process_name = 'crosscheck_itunes_cleanup'
  m_setup_logging(v_process_name)

  recs_deleted = LibraryFileSpec.where(isitunes: true).delete_all
  m_log(v_process_name, 'Info', "Number of records deleted from the Library File Specs table: #{recs_deleted}")

  LibraryRoot.where(isitunes: true).find_each do |ar_lr_rec|
    m_log(v_process_name, 'Info', "Pruning the tree: #{ar_lr_rec.name}")

    Library.where(name: ar_lr_rec.name).where(isroot: true).find_each do |ar_l_rec|
      m_log(v_process_name, 'Info', "Library root id of tree being pruned: #{ar_l_rec.id}")
      m_prune_tree(ar_l_rec.id, ar_l_rec.id)
    end
  end
  
end