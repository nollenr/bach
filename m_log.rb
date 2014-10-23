def m_log(p_process_name, p_log_message_type, p_log_message)
  runid = Run.where(process_name: p_process_name).maximum('run_id')
  Log.create(run_id: runid, process_name: p_process_name, log_message_type: p_log_message_type, log_message: p_log_message)
  return true
end
