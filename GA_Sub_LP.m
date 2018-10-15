function [x1,fv] = GA_Sub_LP(Lower_B,Upper_B,Objective,VariableType,NonbindingConstraint,DemandConstraint,LBNonbindingConstraint,UBNonbindingConstraint,LBDemandConstraint,UBDemandConstraint)
cplex=Cplex;
nb_var=size(Objective,2);
cplex.Model.sense = 'minimize';
cplex.Model.obj = Objective';
cplex.Model.lb = Lower_B';
cplex.Model.ub = Upper_B';
% cplex.Model.lb = zeros(1,nb_var)';
% cplex.Model.ub = inf*ones(1,nb_var)';
cplex.Model.ctype = VariableType;
cplex.Model.A = [NonbindingConstraint;DemandConstraint];
cplex.Model.lhs = [LBNonbindingConstraint';LBDemandConstraint'];
cplex.Model.rhs = [UBNonbindingConstraint';UBDemandConstraint'];
    %----------------- Optimize the problem------------------
cplex.solve();
flag=  cplex.Solution.status;
if flag ==101
    x1=cplex.Solution.x;
else 
    x1=Lower_B';
end

%x1=ceil(x1);
fv=Objective*x1;
end

