function [cplex] = Parameter()
%================初始化=================
cplex = Cplex;



%==========================冲突显示==============================
cplex.Param.conflict.display.Cur=2;
%     0 = no display
%     1 = summary display
%     2 = display every model being solved
cplex.Param.workmem.Cur=128;
%-------------------------------内存强调-----------------------------------
cplex.Param.emphasis.memory.Cur='reduced memory emphasis';




%-------------------------------存储--------------
cplex.Param.output.writelevel.Cur=0;
%      0 = auto
%      1 = all values
%      2 = discrete values
%      3 = non-zero values
%      4 = non-zero discrete values





%-------------------------并行计算---------------------
cplex.Param.parallel.Cur=0;
%    -1 = opportunistic
%     0 = automatic
%     1 = deterministic





%-------------------------求解目标---------------------
cplex.Param.solutiontarget.Cur=0;
%     0 = auto
%     1 = optimal solution to convex problem
%     2 = first-order optimal solution




%---------------------优化时间--------------------
cplex.Param.timelimit.Cur=10800*60;
%----------------调节------------------------
% cplex.Param.tune.display.Cur=0;
% %      0 = no display
% %      1 = minimal display
% %      2 = display settings being tried
% %      3 = display settings and logs 
% cplex.Param.tune.measure.Cur=1;
% %     1 = average
% %     2 = minmax
% cplex.Param.tune.repeat.Cur=1;%重复求解的次数
% cplex.Param.tune.timelimit.Cur=100000;




%------------------------------优化的原则-------------------------------------
% 0 = balance optimality and integer feasibility
% 1 = integer feasibility
% 2 = optimality
% 3 = moving best bound
% 4 = finding hidden feasible solutions
%强调整数可行性
cplex.Param.emphasis.mip.Cur=0;





%-------------------------松弛测度----------------------------
%最小可以允许的松弛量
cplex.Param.feasopt.tolerance.Cur=0.0001;
%测量松弛量的方法
cplex.Param.feasopt.mode.Cur=0;
% 0 = find minimum-sum relaxation
% 1 = find optimal minimum-sum relaxation
% 2 = find minimum number of relaxations
% 3 = find optimal relaxation with minimum number of relaxations
% 4 = find minimum quadratic-sum relaxation
% 5 = find optimal minimum quadratic-sum relaxation



%====================预处理==================
%++++++++++++++++++++线性约束++++++++++++++++
cplex.Param.preprocessing.linear.Cur = 1;
cplex.Param.preprocessing.dependency.Cur= 1;
%-1 = automatic
%0 = off
%1 = at beginning
%2 = at end
%3 = at both beginning and end
%-------主问题与对偶问题--------------------
cplex.Param.preprocessing.reduce.Cur=3;
%      0 = no primal and dual reductions
%      1 = only primal reductions
%      2 = only dual reductions
%      3 = both primal and dual reductions
%----------MIP重复预处理
%-1 = automatic
%0 = off
%1 = repeat presolve without cuts
%2 = repeat presolve with cuts
%3 = repeat presolve with cuts and allow new root cuts
cplex.Param.preprocessing.repeatpresolve.Cur=-1;
%-----------------------消除对称性-----------------------
%indicator for symmetric reductions
% -1   = automatic
% 0   = off
% 1-5 = increasing aggressive levels
cplex.Param.preprocessing.symmetry.Cur=-1;




%-------------------------线性规划以及二次规划运用的算法-------------------
%  0 = automatic
%  1 = primal simplex
%  2 = dual simplex
%  3 = network simplex
%  4 = barrier
%  5 = sifting
%  6 = concurrent dual, barrier, and primal
cplex.Param.lpmethod.Cur=0;
cplex.Param.qpmethod.Cur=0;




%------------------------筛选子问题算法
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




%------------------------障碍子问题算法










%-----------------------单纯形---------------------------
 cplex.Param.simplex.crash.Cur=1;%选择初始解时是否考虑
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











%--------------------------混合整数规划相关参数设置------------------------
%-------------------割平面-------------------(数字越大生成的割越多)
cplex.Param.mip.cuts.covers.Cur=0;%覆盖割；
cplex.Param.mip.cuts.flowcovers.Cur=0; %流覆盖；
cplex.Param.mip.cuts.cliques.Cur=0;%团割；寻找01变量间的逻辑冲突
cplex.Param.mip.cuts.disjunctive.Cur=0;%分离式分割（例如分支定界）；
cplex.Param.mip.cuts.gubcovers.Cur=0;%广义上界割；
cplex.Param.mip.cuts.gomory.Cur=0; %普通割平面；
cplex.Param.mip.cuts.implied.Cur=0; %隐式割平面；整数变量意味着对连续变量有约束，找这些约束
cplex.Param.mip.cuts.mcfcut.Cur=0;%多商品流割；
cplex.Param.mip.cuts.pathcut.Cur=0;%径路割平面；
cplex.Param.mip.cuts.zerohalfcut.Cur=0;% 0半割，如果上界下降不快使用
%---------------------mip诊断-----------------
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
%---------mip---限制参数其他参数-----------------
cplex.Param.mip.limits.aggforcut.Cur=3;%限制迭代时候的割平面数量
cplex.Param.mip.limits.auxrootthreads.Cur=0;%使用辅助线程
cplex.Param.threads.Cur=0;
%     0 = automatic
%     1 = sequential
%     >1  parallel
cplex.Param.mip.limits.cutpasses.Cur=0;%pass的割平面数
cplex.Param.mip.limits.eachcutlimit.Cur=0;%每一类型割的限制
cplex.Param.mip.limits.gomorycand.Cur=200;%普通割平面的备选上限
cplex.Param.mip.limits.gomorypass.Cur=0;
cplex.Param.mip.limits.nodes.Cur=9e+18;
cplex.Param.mip.limits.polishtime.Cur=0;%精化解的时间
cplex.Param.mip.limits.populate.Cur=20;%一次召唤产生解的限制；
cplex.Param.mip.limits.probetime.Cur=1e+75;% 探测时间上限
cplex.Param.mip.limits.repairtries.Cur=0;% 尝试修复启发式方法的次数
cplex.Param.mip.limits.solutions.Cur=9e+18;%解的个数，基本用不上
cplex.Param.mip.limits.strongcand.Cur=10;%强分支的上限，能够更好的避免走错路，但是每个节点更花时间
cplex.Param.mip.limits.strongit.Cur=0;%强分支迭代上限
cplex.Param.mip.limits.submipnodelim.Cur=500;%mip子问题的迭代次数
cplex.Param.mip.limits.treememory.Cur=1e+75;%树存储的内存限制
%===================确定整数规划的排序ans =
cplex.Param.mip.ordertype.Cur=1;% 全变量根本没有成本函数
%      0 = none
%      1 = decreasing cost
%      2 = increasing bound range
%      3 = increasing cost per coefficient count
%=====================细化================
% cplex.Param.mip.polishafter.absmipgap.Cur=20;%绝对gap达到多大后开始做细化；
% cplex.Param.mip.polishafter.mipgap.Cur=0.05;%绝对gap达到多大后开始做细化
% cplex.Param.mip.polishafter.nodes.Cur=9e+18;
% cplex.Param.mip.polishafter.solutions.Cur=9e+18;
% cplex.Param.mip.polishafter.time.Cur=9e+18;
%======================解池==================
cplex.Param.mip.pool.absgap.Cur=9e+18;%绝对gap
cplex.Param.mip.pool.relgap.Cur=9e+18;%绝对gap
cplex.Param.mip.pool.capacity.Cur=2e+18;%solution pool的大小
cplex.Param.mip.pool.intensity.Cur=0;
%     0 = automatic
%     1 = mild: generate few solutions quickly
%     2 = moderate: generate a larger number of solutions
%     3 = aggressive: generate many solutions and expect performance penalty
%     4 = very aggressive: enumerate all practical solutions
%-------------解池的替换策略--------------
cplex.Param.mip.pool.replace.Cur = 0;
%     0 = replace oldest solutions
%     1 = replace solutions with worst objective
%     2 = replace least diverse solutions
%=================mip的搜索策略====================
cplex.Param.mip.strategy.backtrack.Cur=0.999;%回溯次数（越低回溯越少，影响速度）
cplex.Param.mip.strategy.bbinterval.Cur=7;%挑选最佳边界节点的频率
cplex.Param.mip.strategy.branch.Cur=0;
%     -1 = down branch first
%      0 = automatic
%      1 = up branch first 
cplex.Param.mip.strategy.fpheur.Cur=0;
% feasibility pump heuristic(该方法，暂时放弃目标函数，寻找可行解)
%     -1 = none
%      0 = automatic
%      1 = feasibility
%    2 = objective and feasibility
cplex.Param.mip.strategy.heuristicfreq.Cur=0;
% frequency to apply periodic heuristic algorithm
%     -1 = none
%      0 = automatic
%      positive values at this frequency
%====================精华策略==================精华能够尽量避免走错了，但是影响速度
cplex.Param.mip.strategy.dive.Cur=0;
%     0 = automatic
%     1 = traditional dive
%     2 = probing dive
%     3 = guided dive 
%将节点信息存储在硬盘上
cplex.Param.mip.strategy.file.Cur=0;
%     0 = no node file
%     1 = node file in memory and compressed
%     2 = node file on disk
%     3 = node file on disk and compressed
%=====================统计kappa值，由此可了解模型的复杂度==================
 cplex.Param.mip.strategy.kappastats.Cur=0;
%=============每次分支策略----------------
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
%      1 = moderate(probe就是避免走错路，但是会耗费内存)
%      2 = aggressive
%      3 = very aggressive
cplex.Param.mip.strategy.rinsheur.Cur=0; %RINS的启发式方法，即每次迭代增加一个小的MIP！与subMIP的计算次数有关
%     -1 = none
%      0 = automatic
%      positive values at this frequency
cplex.Param.mip.strategy.search.Cur=0;%只兼容informational callback
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
%------------------------------收敛参数----------------------------
cplex.Param.mip.tolerances.absmipgap.Cur=cplex.Param.mip.tolerances.absmipgap.Def;
cplex.Param.mip.tolerances.mipgap.Cur=0.0005;
cplex.Param.mip.tolerances.integrality.Cur=0.0001; %最大0.5
cplex.Param.mip.tolerances.objdifference.Cur=0;% 由于目标函数变化不大，因此需要设为0
cplex.Param.mip.tolerances.relobjdifference.Cur=0;% 由于目标函数变化不大，因此需要设为0
cplex.Param.mip.tolerances.lowercutoff.Cur=1.0e-75;
cplex.Param.mip.tolerances.lowercutoff.Cur=1.0e+75;


end

