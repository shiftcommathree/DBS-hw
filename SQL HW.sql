--3
SELECT petName,petType 
FROM Pet 
WHERE (Extract(year FROM Pet.dateRegistered) = 2001);

--4
SELECT sFName,sLName,salary,MAX(salary) AS maxSalary v
FROM STAFF 
WHERE position NOT LIKE 'manager' 
GROUP BY sFName,sLName,salary;

--5
SELECT sFName,sLName,salary 
FROM STAFF 
WHERE salary >  (SELECT AVG(salary) FROM STAFF);

--6
SELECT AVG(endDate - startDate) AS averageDays 
FROM PetTreatment;

SELECT AVG(endDate – startDate) FROM PetTreatment;

--7
SELECT clinicNo,city,state,penNo,penStatus 
FROM  Clinic INNER JOIN Pen USING(clinicNo);

--8
SELECT sFName,sLName 
FROM Clinic INNER JOIN Staff USING(clinicNo) 
WHERE position LIKE 'manager' AND city = 'Brea' ;

--9
SELECT oFName,oLName 
FROM (PetOWner INNER JOIN Pet USING(ownerNo)) 
WHERE petType LIKE 'Chihuahua';

--10
SELECT oFName,oLName 
FROM ( (PetOWner INNER JOIN Pet USING(ownerNo))  INNER JOIN Clinic ON Pet.clinicNo = Clinic.clinicNo )
WHERE city LIKE 'Fullerton';

--11 
SELECT petName,petType 
FROM (  (Pet AS p INNER JOIN Examination AS e p.petNo = e.petNo AS T ) INNER JOIN (PetTreatment AS pT INNER JOIN Treatment AS tR ON pt.treatNo = tR.treatNo AS Y )  ON T.examNo = Y.examNo ) AS TY

SELECT petName,petType 
FROM (Pet pt INNER JOIN  (Examination ex INNER JOIN  (PetTreatment ptr INNER JOIN Treatment trm ON ptr.treatNo = trm.treatNo) ON ex.examNo = ptr.examNo ) ON pt.petNo = ex.petNo) 
WHERE ( ((endDate - startDate )  > 2) AND (trm.cost > 100 ));

SELECT petName,petType,cost, (endDate - startDate) AS daysBetween FROM (Pet pt INNER JOIN  (Examination ex INNER JOIN  (PetTreatment ptr INNER JOIN Treatment trm ON ptr.treatNo = trm.treatNo) ON ex.examNo = ptr.examNo ) ON pt.petNo = ex.petNo)

SELECT petName,petType FROM ((Pet  INNER JOIN Examination ON Pet.petNo = Examination.petNo) ) AS B WHERE B.petType LIKE 'chihuahua';

--12
SELECT sFNAME,sLNAME,position 
FROM (STAFF INNER JOIN CLINIC USING(clinicNo)) 
WHERE position LIKE 'manager' AND (staffNo <> mgrStaffNo  );

--13
SELECT petType,MAX(cost) 
FROM (  Pet INNER JOIN (Examination INNER JOIN (PetTreatment pt INNER JOIN Treatment tr ON pt.treatNo = tr.treatNo ) USING(examNo)) ON Pet.petNO = Examination.petNo) 
GROUP BY petType;

--14
SELECT Max((to_char(dateRegistered,'MON'))) 
FROM Pet;

--15
SELECT petType,AVG(cost) 
FROM (Pet INNER JOIN (Examination INNER JOIN (PetTreatment INNER JOIN Treatment ON PetTreatment.treatNO = Treatment.treatNo) USING(examNo)) USING(petNo)) 
GROUP BY petType;


--16
SELECT oFName,oLName,COUNT(*) 
FROM (PetOWner o Join Pet p ON o.ownerNo = p.ownerNo ) 
GROUP BY o.oFName,o.oLName 
HAVING (COUNT(p.ownerNo) > 1);


--17
SELECT drugName AS "Drug Name",inStock AS "Quantity in stock" 
FROM ( Pharmacy JOIN PharmClinicStock using(drugNo)) 
WHERE (inStock < reorderLevel) 
ORDER BY inStock;


--18
SELECT city, SUM(cost) 
FROM (Clinic cl INNER JOIN (PetOWner pto INNER JOIN (Pet pt INNER JOIN( Examination ex INNER JOIN  (PetTreatment ptr INNER JOIN Treatment tr USING(treatNo)) ON ex.examNo = ptr.examNo) USING (petNo)) ON pt.ownerNo = pto.ownerNo) ON cl.clinicNo = pto.clinicNo) 
GROUP BY cl.city;

SELECT clinicNo FROM (Clinic cl INNER JOIN (PetOWner pto INNER JOIN (Pet pt INNER JOIN( Examination ex INNER JOIN  (PetTreatment ptr INNER JOIN Treatment tr USING(treatNo)) ON ex.examNo = ptr.examNo) USING (petNo)) ON pt.ownerNo = pto.ownerNo) ON cl.clinicNo = pto.clinicNo);