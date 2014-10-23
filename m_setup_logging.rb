def m_setup_logging(p_process_name)
  
  # first, create a new run for this process
  runrec = Run.create(process_name: p_process_name, run_date: DateTime.now)
  runid = Run.where(id: runrec.id).pluck(:run_id)
  
  Log.where(process_name: p_process_name).each do |logrec|
    LogArchive.create(logrec.dup.attributes)
  end
  
  Log.where(process_name: p_process_name).delete_all
  
  return true
  
end
