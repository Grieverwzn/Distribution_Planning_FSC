function [cplex] = Parameter()
%================��ʼ��=================
cplex = Cplex;



%==========================��ͻ��ʾ==============================
cplex.Param.conflict.display.Cur=2;
%     0 = no display
%     1 = summary display
%     2 = display every model being solved
cplex.Param.workmem.Cur=128;
%-------------------------------�ڴ�ǿ��-----------------------------------
cplex.Param.emphasis.memory.Cur='reduced memory emphasis';




%-------------------------------�洢--------------
cplex.Param.output.writelevel.Cur=0;
%      0 = auto
%      1 = all values
%      2 = discrete values
%      3 = non-zero values
%      4 = non-zero discrete values





%-------------------------���м���---------------------
cplex.Param.parallel.Cur=0;
%    -1 = opportunistic
%     0 = automatic
%     1 = deterministic





%-------------------------���Ŀ��---------------------
cplex.Param.solutiontarget.Cur=0;
%     0 = auto
%     1 = optimal solution to convex problem
%     2 = first-order optimal solution




%---------------------�Ż�ʱ��--------------------
cplex.Param.timelimit.Cur=10800*60;
%----------------����------------------------
% cplex.Param.tune.display.Cur=0;
% %      0 = no display
% %      1 = minimal display
% %      2 = display settings being tried
% %      3 = display settings and logs 
% cplex.Param.tune.measure.Cur=1;
% %     1 = average
% %     2 = minmax
% cplex.Param.tune.repeat.Cur=1;%�ظ����Ĵ���
% cplex.Param.tune.timelimit.Cur=100000;




%------------------------------�Ż���ԭ��-------------------------------------
% 0 = balance optimality and integer feasibility
% 1 = integer feasibility
% 2 = optimality
% 3 = moving best bound
% 4 = finding hidden feasible solutions
%ǿ������������
cplex.Param.emphasis.mip.Cur=0;





%-------------------------�ɳڲ��----------------------------
%��С����������ɳ���
cplex.Param.feasopt.tolerance.Cur=0.0001;
%�����ɳ����ķ���
cplex.Param.feasopt.mode.Cur=0;
% 0 = find minimum-sum relaxation
% 1 = find optimal minimum-sum relaxation
% 2 = find minimum number of relaxations
% 3 = find optimal relaxation with minimum number of relaxations
% 4 = find minimum quadratic-sum relaxation
% 5 = find optimal minimum quadratic-sum relaxation



%====================Ԥ����==================
%++++++++++++++++++++����Լ��++++++++++++++++
cplex.Param.preprocessing.linear.Cur = 1;
cplex.Param.preprocessing.dependency.Cur= 1;
%-1 = automatic
%0 = off
%1 = at beginning
%2 = at end
%3 = at both beginning and end
%-------���������ż����--------------------
cplex.Param.preprocessing.reduce.Cur=3;
%      0 = no primal and dual reductions
%      1 = only primal reductions
%      2 = only dual reductions
%      3 = both primal and dual reductions
%----------MIP�ظ�Ԥ����
%-1 = automatic
%0 = off
%1 = repeat presolve without cuts
%2 = repeat presolve with cuts
%3 = repeat presolve with cuts and allow new root cuts
cplex.Param.preprocessing.repeatpresolve.Cur=-1;
%-----------------------�����Գ���-----------------------
%indicator for symmetric reductions
% -1   = automatic
% 0   = off
% 1-5 = increasing aggressive levels
cplex.Param.preprocessing.symmetry.Cur=-1;




%-------------------------���Թ滮�Լ����ι滮���õ��㷨-------------------
%  0 = automatic
%  1 = primal simplex
%  2 = dual simplex
%  3 = network simplex
%  4 = barrier
%  5 = sifting
%  6 = concurrent dual, barrier, and primal
cplex.Param.lpmethod.Cur=0;
cplex.Param.qpmethod.Cur=0;




%------------------------ɸѡ�������㷨
cplex.Param.sifting.algorithm.Cur=0;
%     0 = automatic
%     1 = primal simplex
%     2 = dual simplex
%     3 = network simplex
%     4 = barrier
cplex.Param.sifting.iterations.Cur=9e+20;
cplex.Param.sifting.display.Cur=0;
%     0 = no display
%     1 = display major sifting iterations
%     2 = display work LP logs




%------------------------�ϰ��������㷨










%-----------------------������---------------------------
 cplex.Param.simplex.crash.Cur=1;%ѡ���ʼ��ʱ�Ƿ���
%     LP primal:  0 = ignore objective coefficients during crash
%           1 or -1 = alternate ways of using objective coefficients
%     LP dual:    1 = default starting basis
%           0 or -1 = aggressive starting basis
%     QP primal: -1 = slack basis
%                 0 = ignore Q terms and use LP solver for crash
%                 1 = ignore objective and use LP solver for crash
%     QP dual:   -1 = slack basis
%           0 or  1 = use Q terms for crash
cplex.Param.simplex.dgradient.Cur=0;
%     0 = determined automatically
%     1 = standard dual pricing
%     2 = steepest-edge pricing
%     3 = steepest-edge pricing in slack space
%     4 = steepest-edge pricing, unit initial norms
%     5 = devex pricing
cplex.Param.simplex.pgradient.Cur=0;
%    -1 = reduced-cost pricing
%     0 = hybrid reduced-cost and devex pricing
%     1 = devex pricing
%     2 = steepest-edge pricing
%     3 = steepest-edge pricing, 1 initial norms
%     4 = full pricing
cplex.Param.simplex.display.Cur=0;
%     0 = no display
%     1 = display after refactorization
%     2 = display every iteration
% cplex.Param.simplex.pricing.Cur=0;%
% cplex.Param.simplex.refactor.Cur=0;
cplex.Param.simplex.tolerances.feasibility.Cur =1e-6;
cplex.Param.simplex.tolerances.optimality.Cur =1e-6;











%--------------------------��������滮��ز�������------------------------
%-------------------��ƽ��-------------------(����Խ�����ɵĸ�Խ��)
cplex.Param.mip.cuts.covers.Cur=0;%���Ǹ
cplex.Param.mip.cuts.flowcovers.Cur=0; %�����ǣ�
cplex.Param.mip.cuts.cliques.Cur=0;%�ŸѰ��01��������߼���ͻ
cplex.Param.mip.cuts.disjunctive.Cur=0;%����ʽ�ָ�����֧���磩��
cplex.Param.mip.cuts.gubcovers.Cur=0;%�����Ͻ�
cplex.Param.mip.cuts.gomory.Cur=0; %��ͨ��ƽ�棻
cplex.Param.mip.cuts.implied.Cur=0; %��ʽ��ƽ�棻����������ζ�Ŷ�����������Լ��������ЩԼ��
cplex.Param.mip.cuts.mcfcut.Cur=0;%����Ʒ���
cplex.Param.mip.cuts.pathcut.Cur=0;%��·��ƽ�棻
cplex.Param.mip.cuts.zerohalfcut.Cur=0;% 0������Ͻ��½�����ʹ��
%---------------------mip���-----------------
cplex.Param.mip.display.Cur=2;
%      0 = no display
%      1 = display integer feasible solutions
%      2 = display nodes under 'mip interval' control
%      3 = same as 2, but add information on node cuts
%      4 = same as 3, but add LP display for root node
%      5 = same as 3, but add LP display for all nodes
%--------------------mip interval----------------
cplex.Param.mip.interval.Cur=0;
%0 = automatic (equivalent to -1000)
%x>0 = display every x nodes and new incumbents
%x<0 = progressively less log output over time (closer to 0: more frequent)
%---------mip---���Ʋ�����������-----------------
cplex.Param.mip.limits.aggforcut.Cur=3;%���Ƶ���ʱ��ĸ�ƽ������
cplex.Param.mip.limits.auxrootthreads.Cur=0;%ʹ�ø����߳�
cplex.Param.threads.Cur=0;
%     0 = automatic
%     1 = sequential
%     >1  parallel
cplex.Param.mip.limits.cutpasses.Cur=0;%pass�ĸ�ƽ����
cplex.Param.mip.limits.eachcutlimit.Cur=0;%ÿһ���͸������
cplex.Param.mip.limits.gomorycand.Cur=200;%��ͨ��ƽ��ı�ѡ����
cplex.Param.mip.limits.gomorypass.Cur=0;
cplex.Param.mip.limits.nodes.Cur=9e+18;
cplex.Param.mip.limits.polishtime.Cur=0;%�������ʱ��
cplex.Param.mip.limits.populate.Cur=20;%һ���ٻ�����������ƣ�
cplex.Param.mip.limits.probetime.Cur=1e+75;% ̽��ʱ������
cplex.Param.mip.limits.repairtries.Cur=0;% �����޸�����ʽ�����Ĵ���
cplex.Param.mip.limits.solutions.Cur=9e+18;%��ĸ����������ò���
cplex.Param.mip.limits.strongcand.Cur=10;%ǿ��֧�����ޣ��ܹ����õı����ߴ�·������ÿ���ڵ����ʱ��
cplex.Param.mip.limits.strongit.Cur=0;%ǿ��֧��������
cplex.Param.mip.limits.submipnodelim.Cur=500;%mip������ĵ�������
cplex.Param.mip.limits.treememory.Cur=1e+75;%���洢���ڴ�����
%===================ȷ�������滮������ans =
cplex.Param.mip.ordertype.Cur=1;% ȫ��������û�гɱ�����
%      0 = none
%      1 = decreasing cost
%      2 = increasing bound range
%      3 = increasing cost per coefficient count
%=====================ϸ��================
% cplex.Param.mip.polishafter.absmipgap.Cur=20;%����gap�ﵽ����ʼ��ϸ����
% cplex.Param.mip.polishafter.mipgap.Cur=0.05;%����gap�ﵽ����ʼ��ϸ��
% cplex.Param.mip.polishafter.nodes.Cur=9e+18;
% cplex.Param.mip.polishafter.solutions.Cur=9e+18;
% cplex.Param.mip.polishafter.time.Cur=9e+18;
%======================���==================
cplex.Param.mip.pool.absgap.Cur=9e+18;%����gap
cplex.Param.mip.pool.relgap.Cur=9e+18;%����gap
cplex.Param.mip.pool.capacity.Cur=2e+18;%solution pool�Ĵ�С
cplex.Param.mip.pool.intensity.Cur=0;
%     0 = automatic
%     1 = mild: generate few solutions quickly
%     2 = moderate: generate a larger number of solutions
%     3 = aggressive: generate many solutions and expect performance penalty
%     4 = very aggressive: enumerate all practical solutions
%-------------��ص��滻����--------------
cplex.Param.mip.pool.replace.Cur = 0;
%     0 = replace oldest solutions
%     1 = replace solutions with worst objective
%     2 = replace least diverse solutions
%=================mip����������====================
cplex.Param.mip.strategy.backtrack.Cur=0.999;%���ݴ�����Խ�ͻ���Խ�٣�Ӱ���ٶȣ�
cplex.Param.mip.strategy.bbinterval.Cur=7;%��ѡ��ѱ߽�ڵ��Ƶ��
cplex.Param.mip.strategy.branch.Cur=0;
%     -1 = down branch first
%      0 = automatic
%      1 = up branch first 
cplex.Param.mip.strategy.fpheur.Cur=0;
% feasibility pump heuristic(�÷�������ʱ����Ŀ�꺯����Ѱ�ҿ��н�)
%     -1 = none
%      0 = automatic
%      1 = feasibility
%    2 = objective and feasibility
cplex.Param.mip.strategy.heuristicfreq.Cur=0;
% frequency to apply periodic heuristic algorithm
%     -1 = none
%      0 = automatic
%      positive values at this frequency
%====================��������==================�����ܹ����������ߴ��ˣ�����Ӱ���ٶ�
cplex.Param.mip.strategy.dive.Cur=0;
%     0 = automatic
%     1 = traditional dive
%     2 = probing dive
%     3 = guided dive 
%���ڵ���Ϣ�洢��Ӳ����
cplex.Param.mip.strategy.file.Cur=0;
%     0 = no node file
%     1 = node file in memory and compressed
%     2 = node file on disk
%     3 = node file on disk and compressed
%=====================ͳ��kappaֵ���ɴ˿��˽�ģ�͵ĸ��Ӷ�==================
 cplex.Param.mip.strategy.kappastats.Cur=0;
%=============ÿ�η�֧����----------------
cplex.Param.mip.strategy.miqcpstrat.Cur=0;
%      0 = automatic
%      1 = solve QCP relaxation at each node
%      2 = solve LP relaxation at each node
cplex.Param.mip.strategy.nodeselect.Cur=1;
%      0 = depth-first search
%      1 = best-bound search
%      2 = best-estimate search
%      3 = alternate best-estimate search
cplex.Param.mip.strategy.presolvenode.Cur=0;
%     -1 = no node presolve
%      0 = automatic
%      1 = force node presolve
%      2 = node probing
cplex.Param.mip.strategy.probe.Cur=0;
%     -1 = no probing
%      0 = automatic
%      1 = moderate(probe���Ǳ����ߴ�·�����ǻ�ķ��ڴ�)
%      2 = aggressive
%      3 = very aggressive
cplex.Param.mip.strategy.rinsheur.Cur=0; %RINS������ʽ��������ÿ�ε�������һ��С��MIP����subMIP�ļ�������й�
%     -1 = none
%      0 = automatic
%      positive values at this frequency
cplex.Param.mip.strategy.search.Cur=0;%ֻ����informational callback
%      0 = automatic
%      1 = traditional branch-and-cut search
%      2 = dynamic search
cplex.Param.mip.strategy.startalgorithm.Cur=0;
cplex.Param.mip.strategy.subalgorithm.Cur=0;
%      0 = automatic
%      1 = primal simplex
%      2 = dual simplex
%      3 = network simplex
%      4 = barrier
%      5 = sifting
%      6 = concurrent
cplex.Param.mip.strategy.variableselect.Cur=0;
%     -1 = minimum integer infeasibility
%      0 = automatic
%      1 = maximum integer infeasibility
%      2 = pseudo costs
%      3 = strong branching
%      4 = pseudo reduced costs
%------------------------------��������----------------------------
cplex.Param.mip.tolerances.absmipgap.Cur=cplex.Param.mip.tolerances.absmipgap.Def;
cplex.Param.mip.tolerances.mipgap.Cur=0.0005;
cplex.Param.mip.tolerances.integrality.Cur=0.0001; %���0.5
cplex.Param.mip.tolerances.objdifference.Cur=0;% ����Ŀ�꺯���仯���������Ҫ��Ϊ0
cplex.Param.mip.tolerances.relobjdifference.Cur=0;% ����Ŀ�꺯���仯���������Ҫ��Ϊ0
cplex.Param.mip.tolerances.lowercutoff.Cur=1.0e-75;
cplex.Param.mip.tolerances.lowercutoff.Cur=1.0e+75;


end

