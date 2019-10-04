clear;
close;
clc;
PopulationSize=30;
Dimensions = 2;
Xmin = -10;
Xmax = 10;
Vmin = -10;
Vmax = 10;
c1= 2;
c2= 2;
w = 0.5;
MaxIterations = 25;
%a2=randi([-10 10],1,1);
%a0=randi([-10 10],1,1);
%a1=randi([-10 10],1,1);

a2=1
a1=0
a0=-4

%if a2*a0 <0
%    a2=abs(a2);
%   a0=abs(a0);
%end
%while a1 < sqrt(4*a2*a0)
%    a1 = randi([-10 10],1,1);
%end
%a1=round(sqrt(4*a2*a0))+ abs(randi([-10 10],1,1));
%..........................initialization..................................
Positions_X  = Xmin+(Xmax-Xmin)*rand(PopulationSize,Dimensions);
%Positions_X
Velocities_V = Vmin+(Vmax-Vmin)*rand(PopulationSize,Dimensions);
%Velocities_V
%-------------We just created random particles having random velocities----
PBestPositions = Positions_X;
%----- Initial P_Best_Positions are the same as the  Positions_X-----------
for Particle=1:PopulationSize
    PBestFitnesses(Particle) = (a2*sum(Positions_X(Particle,:).^2))+(a1*sum(Positions_X(Particle,:) ))+a0;
    %PBestFitnesses(Particle)
end
[LBestFitness,LBestIndex] = min(PBestFitnesses);
LBestPosition = PBestPositions(LBestIndex,:);
%LBestPosition
%.....................intialization of population ,pbestfitness,........
%.....................pbestposition, LBestposition.......................
for Iteration = 1:MaxIterations
    tic
    w = 0.9 - 0.8 * Iteration/MaxIterations;
    %a2=randi([-10 10],1,1);
    %a0=randi([-10 10],1,1);
    %a1=randi([-10 10],1,1);
    %if a2*a0 <0
    %    a2=abs(a2);
    %    a0=abs(a0);
    %end
    %while a1 < sqrt(4*a2*a0)
    %    a1 = randi([-10 10],1,1);
    %end
    %a1=round(sqrt(4*a2*a0))+ abs(randi([-10 10],1,1));
    a2=1;
    a1=0;
    a0=-4;
    for Particle = 1: PopulationSize
        Intertia              = w * Velocities_V(Particle,:);
        CognitionAcceleration = c1*rand*(-Positions_X(Particle,:)+ PBestPositions(Particle,:));
        SocialAcceleration    = c2*rand*(-Positions_X(Particle,:)+ LBestPosition);
        Velocities_V(Particle,:) = Intertia + CognitionAcceleration + SocialAcceleration;
        CurrentParticleVelocity = Velocities_V(Particle,:);
        %................Velocity Update..........................
        CurrentParticleVelocity(CurrentParticleVelocity > Vmax)=Vmax;
        CurrentParticleVelocity(CurrentParticleVelocity < Vmin)=Vmin;
        Velocities_V(Particle,:)= CurrentParticleVelocity;
        %...................Velocity Clamping......................
        CurrentPosition = Positions_X(Particle,:);
        NewPosition = CurrentPosition + Velocities_V(Particle,:);
        %NewPosition
        NewPosition(NewPosition > Xmax) = Xmax;
        NewPosition(NewPosition < Xmin) = Xmin;
        %..................Position Clamping....................
        Positions_X(Particle,:) = NewPosition;
        %...................Position Update........................
        %Newfitness = sum(NewPosition.^2);
        Newfitness=(a2*sum(NewPosition.^2))+(a1*sum(NewPosition))+a0;
        if Newfitness < PBestFitnesses(Particle)
            PBestFitnesses(Particle) = Newfitness;
            PBestPositions(Particle,:) = NewPosition;
        end
        %.................Update the PBest.................................
        if Newfitness < LBestFitness
            LBestFitness  = Newfitness;
            LBestPosition = NewPosition;
        end  
        %.................Update the LBest.................................
    end
    fprintf('a2: %d a1: %d a0: %d  Iteration: %d   Bset Fitness: %e ',a2,  a1,  a0,Iteration, LBestFitness);
    g=sprintf('%d ', CurrentPosition);
    fprintf(' Roots X1 X2: %s ',g)
    BestFitness(Iteration) = LBestFitness;
    toc
    end
plot(BestFitness);grid on;
LBestPosition