# Distribution_Planning_Lot_sizing_Decomposition

The .m files are the matlab codes for the Lagrangian subsitituion approach and decomposition algorithm for the Catering Serivces of High-speed Railway (CSHRs)

The programes are coded based on the working paper: **Distribution planning problem for a high-speed
rail catering service considering time-varying demands and pedestrian
congestion: a lot-sizing-based model and decomposition algorithm** which is writiten by the research team from Beijing Jiaotong University directed by Prof. Lei Nie.

The codes are all programed by Dr. Xin Wu. Please contact him when you have any questions xinwu-griever@outlook.com; xinwu@bjtu.edu.cn. Your advises are very important for us. The codes will be constantly updated and improved in the future. 

The codes consist of three parts: 

1. Main programs: 

   The main.m is the key component of the programe to start all concerned algorihtms. The sub-mixed integer programming models decomposed are solved using CPLEX in the file. Thus our programe can only be rightly run when CPLEX interface is rightly installed in a MATLAB enviroment. The concave.m file is the programe to solve a series of univariate concave maximization sub-models. The models are all solved using the fmincon function in MATLAB optimization tool. 

2. All file named HCEA_ is the functions for the hybrid cross entropy algorithm (HCEA) embeded with the convex cocmbinations method (Frank Wolfe algorithm). The HCEA algorihtm is implemented to achieve a comparison analysis with the proposed decomposition method. Defaultly We suggest the user do not use the .m files.  

3. - Data.m provides a toy example 

     “需求表 for lot-sizing problem.xlsx” shows the basic matrix structure of the toy example。 One can use it for education purpose.

   - Data1.m provides a median-scale example (“车次案例.xlsx”)

   - Data2.m provedes a large-scale example on the Beijing-Shaing railway corridor. “Beijing-Shanghai corridor data.xlsx” is the basic timetable that we used. “”需求表 for lot-sizing problem.xlsx” shows the basic trains considered in the case study. 

   - Datarand.m can generate different random case studies to test our algorithms. “nbStopDistr(Beijing-Guanzhou) and “nbStopDistr(Beijing-Shanghai) are distributions generated based on real timetables on the two corridors.

