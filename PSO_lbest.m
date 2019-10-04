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
MaxIterations = 250;

% = (Xmax-Xmin).*rand(1,2) + Xmin;
%a0 = (Xmax-Xmin).*rand(1,2) + Xmax;
%a1 = sqrt(4*a2*a0)

%..........................initialization..................................
Positions_X  = Xmin+(Xmax-Xmin)*rand(PopulationSize,Dimensions);
Velocities_V = Vmin+(Vmax-Vmin)*rand(PopulationSize,Dimensions);
%-------------We just created random particles having random velocities----
PBestPositions = Positions_X;
%----- Initial P_Best_Positions are the same as the  Positions_X-----------
for Particle=1:PopulationSize
    %PBestFitnesses(Particle) = a2*(Positions_X(Particle,:).^2)+ a1*(Positions_X(Particle,:))+ a0;
    PBestFitnesses(Particle) = sum(Positions_X(Particle,:).^2);
end
[GBestFitness,GBestIndex] = min(PBestFitnesses);
GBestPosition = PBestPositions(GBestIndex,:);
%.....................intialization of population ,pbestfitness,........
%.....................pbestposition, gbestposition.......................
for Iteration = 1:MaxIterations
    %w = 0.9 - 0.8 * Iteration/MaxIterations;
    for Particle = 1: PopulationSize
        Intertia              = w * Velocities_V(Particle,:);
        CognitionAcceleration = c1*rand*(-Positions_X(Particle,:)+ PBestPositions(Particle,:));
        SocialAcceleration    = c2*rand*(-Positions_X(Particle,:)+ GBestPosition);
        Velocities_V(Particle,:) = Intertia + CognitionAcceleration + SocialAcceleration;
        CurrentParticleVelocity = Velocities_V(Particle,:);
        %................Velocity Update..........................
        CurrentParticleVelocity(CurrentParticleVelocity > Vmax)=Vmax;
        CurrentParticleVelocity(CurrentParticleVelocity < Vmin)=Vmin;
        Velocities_V(Particle,:)= CurrentParticleVelocity;
        %...................Velocity Clamping......................
        CurrentPosition = Positions_X(Particle,:);
        NewPosition = CurrentPosition + Velocities_V(Particle,:);
        NewPosition(NewPosition > Xmax) = Xmax;
        NewPosition(NewPosition < Xmin) = Xmin;
        %..................Position Clamping....................
        Positions_X(Particle,:) = NewPosition;
        %...................Position Update........................
        Newfitness = sum(NewPosition.^2);
        if Newfitness < PBestFitnesses(Particle)
            PBestFitnesses(Particle) = Newfitness;
            PBestPositions(Particle,:) = NewPosition;
        end
        %.................Update the PBest.................................
        if Newfitness < GBestFitness
            GBestFitness  = Newfitness;
            GBestPosition = NewPosition;
        end  
        %.................Update the GBest.................................
    end
    fprintf('Iteration: %d  Bset Fitness: %e \n',Iteration,  GBestFitness)
    BestFitness(Iteration) = GBestFitness;
    end
plot(BestFitness);grid on;
GBestPosition