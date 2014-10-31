def m_windows_fqfn(p_linux_fqfn)
=begin
  Find the master library record, then see if the library_root exists
  on the linux_fqfn if it does, then replace the library root with
  the windows root and replace all '/' with '\'
  
  there should only ever be ONE "master" record in the LibraryRoot
  how can I enforce that at the database level?
=end
  v_lib_root_master = LibraryRoot.where(ismaster: true).first
  mydummyvar = p_linux_fqfn.gsub(v_lib_root_master.name, v_lib_root_master.windows_name)
  mydummyvar.gsub(%r{/}, '\\')
end
