select distinct m.MemberID as 'Member ID' , firstname as 'First Name', LastName as 'Last Name', mostseverediagnosis as 'Most Severe Diagnosis ID', d.DiagnosisDescription as 'Most Severe Diagnosis Description' , dcm.DiagnosisCategoryID as 'Category ID', dc.CategoryDescription as 'Category Description', dc.CategoryScore as 'Category Score', Isnull(IsMostSevere, 1) as 'Is Most Severe Category' from 
member m left join memberDiagnosis md
on m.MemberID = md.MemberID
left join DiagnosisCategoryMap dcm
on md.DiagnosisID = dcm.DiagnosisID
left join DiagnosisCategory dc
on dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID 
left join
(
    select MemberID ,  min(mdinner.DiagnosisID)  as mostseverediagnosis   from MemberDiagnosis mdinner 
    group by MemberID
)  msd
on m.MemberID = msd.MemberID
left join Diagnosis d
on d.DiagnosisID = mostseverediagnosis
left join 
(
   select MemberID  , min(dcm.DiagnosisCategoryID ) as IsMostSevere from MemberDiagnosis md join DiagnosisCategoryMap dcm
   on md.DiagnosisID = dcm.DiagnosisID
    group by MemberID

) msc
on m.MemberID = msc.MemberID
