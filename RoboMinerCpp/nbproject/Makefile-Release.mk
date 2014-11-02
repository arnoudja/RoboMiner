#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=g++
CXX=g++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=GNU-Linux-x86
CND_DLIB_EXT=so
CND_CONF=Release
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/Animation.o \
	${OBJECTDIR}/AnimationArrayData.o \
	${OBJECTDIR}/AnimationStep.o \
	${OBJECTDIR}/ConfigFile.o \
	${OBJECTDIR}/Database.o \
	${OBJECTDIR}/DatabaseStatement.o \
	${OBJECTDIR}/Ground.o \
	${OBJECTDIR}/GroundChangeStep.o \
	${OBJECTDIR}/GroundUnit.o \
	${OBJECTDIR}/Position.o \
	${OBJECTDIR}/Rally.o \
	${OBJECTDIR}/RoboMine.o \
	${OBJECTDIR}/Robot.o \
	${OBJECTDIR}/robotcode/CallAction.o \
	${OBJECTDIR}/robotcode/CompileInput.o \
	${OBJECTDIR}/robotcode/ConstReturnAction.o \
	${OBJECTDIR}/robotcode/ConstValueProgramItem.o \
	${OBJECTDIR}/robotcode/DumpAction.o \
	${OBJECTDIR}/robotcode/DumpProgramItem.o \
	${OBJECTDIR}/robotcode/IfProgramItem.o \
	${OBJECTDIR}/robotcode/MineAction.o \
	${OBJECTDIR}/robotcode/MineProgramItem.o \
	${OBJECTDIR}/robotcode/MineReturnAction.o \
	${OBJECTDIR}/robotcode/MoveAction.o \
	${OBJECTDIR}/robotcode/MoveProgramItem.o \
	${OBJECTDIR}/robotcode/OperatorProgramItem.o \
	${OBJECTDIR}/robotcode/OreValueProgramItem.o \
	${OBJECTDIR}/robotcode/ProgramAction.o \
	${OBJECTDIR}/robotcode/ProgramItem.o \
	${OBJECTDIR}/robotcode/ProgramItemStatus.o \
	${OBJECTDIR}/robotcode/ReturnAction.o \
	${OBJECTDIR}/robotcode/RobotProgram.o \
	${OBJECTDIR}/robotcode/RotateAction.o \
	${OBJECTDIR}/robotcode/RotateProgramItem.o \
	${OBJECTDIR}/robotcode/SequenceProgramItem.o \
	${OBJECTDIR}/robotcode/SetVariableAction.o \
	${OBJECTDIR}/robotcode/SetVariableProgramItem.o \
	${OBJECTDIR}/robotcode/TimeProgramItem.o \
	${OBJECTDIR}/robotcode/Value.o \
	${OBJECTDIR}/robotcode/ValueProgramItem.o \
	${OBJECTDIR}/robotcode/ValueReturnAction.o \
	${OBJECTDIR}/robotcode/Variable.o \
	${OBJECTDIR}/robotcode/VariableReturnAction.o \
	${OBJECTDIR}/robotcode/VariableStorage.o \
	${OBJECTDIR}/robotcode/VariableValueProgramItem.o \
	${OBJECTDIR}/robotcode/WhileProgramItem.o \
	${OBJECTDIR}/stdafx.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=-L/usr/lib64/mysql -lmysqlclient

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/robominercpp

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/robominercpp: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.cc} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/robominercpp ${OBJECTFILES} ${LDLIBSOPTIONS}

${OBJECTDIR}/Animation.o: Animation.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Animation.o Animation.cpp

${OBJECTDIR}/AnimationArrayData.o: AnimationArrayData.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/AnimationArrayData.o AnimationArrayData.cpp

${OBJECTDIR}/AnimationStep.o: AnimationStep.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/AnimationStep.o AnimationStep.cpp

${OBJECTDIR}/ConfigFile.o: ConfigFile.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/ConfigFile.o ConfigFile.cpp

${OBJECTDIR}/Database.o: Database.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Database.o Database.cpp

${OBJECTDIR}/DatabaseStatement.o: DatabaseStatement.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/DatabaseStatement.o DatabaseStatement.cpp

${OBJECTDIR}/Ground.o: Ground.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Ground.o Ground.cpp

${OBJECTDIR}/GroundChangeStep.o: GroundChangeStep.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/GroundChangeStep.o GroundChangeStep.cpp

${OBJECTDIR}/GroundUnit.o: GroundUnit.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/GroundUnit.o GroundUnit.cpp

${OBJECTDIR}/Position.o: Position.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Position.o Position.cpp

${OBJECTDIR}/Rally.o: Rally.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Rally.o Rally.cpp

${OBJECTDIR}/RoboMine.o: RoboMine.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/RoboMine.o RoboMine.cpp

${OBJECTDIR}/Robot.o: Robot.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Robot.o Robot.cpp

${OBJECTDIR}/robotcode/CallAction.o: robotcode/CallAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/CallAction.o robotcode/CallAction.cpp

${OBJECTDIR}/robotcode/CompileInput.o: robotcode/CompileInput.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/CompileInput.o robotcode/CompileInput.cpp

${OBJECTDIR}/robotcode/ConstReturnAction.o: robotcode/ConstReturnAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/ConstReturnAction.o robotcode/ConstReturnAction.cpp

${OBJECTDIR}/robotcode/ConstValueProgramItem.o: robotcode/ConstValueProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/ConstValueProgramItem.o robotcode/ConstValueProgramItem.cpp

${OBJECTDIR}/robotcode/DumpAction.o: robotcode/DumpAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/DumpAction.o robotcode/DumpAction.cpp

${OBJECTDIR}/robotcode/DumpProgramItem.o: robotcode/DumpProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/DumpProgramItem.o robotcode/DumpProgramItem.cpp

${OBJECTDIR}/robotcode/IfProgramItem.o: robotcode/IfProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/IfProgramItem.o robotcode/IfProgramItem.cpp

${OBJECTDIR}/robotcode/MineAction.o: robotcode/MineAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/MineAction.o robotcode/MineAction.cpp

${OBJECTDIR}/robotcode/MineProgramItem.o: robotcode/MineProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/MineProgramItem.o robotcode/MineProgramItem.cpp

${OBJECTDIR}/robotcode/MineReturnAction.o: robotcode/MineReturnAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/MineReturnAction.o robotcode/MineReturnAction.cpp

${OBJECTDIR}/robotcode/MoveAction.o: robotcode/MoveAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/MoveAction.o robotcode/MoveAction.cpp

${OBJECTDIR}/robotcode/MoveProgramItem.o: robotcode/MoveProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/MoveProgramItem.o robotcode/MoveProgramItem.cpp

${OBJECTDIR}/robotcode/OperatorProgramItem.o: robotcode/OperatorProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/OperatorProgramItem.o robotcode/OperatorProgramItem.cpp

${OBJECTDIR}/robotcode/OreValueProgramItem.o: robotcode/OreValueProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/OreValueProgramItem.o robotcode/OreValueProgramItem.cpp

${OBJECTDIR}/robotcode/ProgramAction.o: robotcode/ProgramAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/ProgramAction.o robotcode/ProgramAction.cpp

${OBJECTDIR}/robotcode/ProgramItem.o: robotcode/ProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/ProgramItem.o robotcode/ProgramItem.cpp

${OBJECTDIR}/robotcode/ProgramItemStatus.o: robotcode/ProgramItemStatus.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/ProgramItemStatus.o robotcode/ProgramItemStatus.cpp

${OBJECTDIR}/robotcode/ReturnAction.o: robotcode/ReturnAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/ReturnAction.o robotcode/ReturnAction.cpp

${OBJECTDIR}/robotcode/RobotProgram.o: robotcode/RobotProgram.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/RobotProgram.o robotcode/RobotProgram.cpp

${OBJECTDIR}/robotcode/RotateAction.o: robotcode/RotateAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/RotateAction.o robotcode/RotateAction.cpp

${OBJECTDIR}/robotcode/RotateProgramItem.o: robotcode/RotateProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/RotateProgramItem.o robotcode/RotateProgramItem.cpp

${OBJECTDIR}/robotcode/SequenceProgramItem.o: robotcode/SequenceProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/SequenceProgramItem.o robotcode/SequenceProgramItem.cpp

${OBJECTDIR}/robotcode/SetVariableAction.o: robotcode/SetVariableAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/SetVariableAction.o robotcode/SetVariableAction.cpp

${OBJECTDIR}/robotcode/SetVariableProgramItem.o: robotcode/SetVariableProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/SetVariableProgramItem.o robotcode/SetVariableProgramItem.cpp

${OBJECTDIR}/robotcode/TimeProgramItem.o: robotcode/TimeProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/TimeProgramItem.o robotcode/TimeProgramItem.cpp

${OBJECTDIR}/robotcode/Value.o: robotcode/Value.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/Value.o robotcode/Value.cpp

${OBJECTDIR}/robotcode/ValueProgramItem.o: robotcode/ValueProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/ValueProgramItem.o robotcode/ValueProgramItem.cpp

${OBJECTDIR}/robotcode/ValueReturnAction.o: robotcode/ValueReturnAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/ValueReturnAction.o robotcode/ValueReturnAction.cpp

${OBJECTDIR}/robotcode/Variable.o: robotcode/Variable.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/Variable.o robotcode/Variable.cpp

${OBJECTDIR}/robotcode/VariableReturnAction.o: robotcode/VariableReturnAction.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/VariableReturnAction.o robotcode/VariableReturnAction.cpp

${OBJECTDIR}/robotcode/VariableStorage.o: robotcode/VariableStorage.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/VariableStorage.o robotcode/VariableStorage.cpp

${OBJECTDIR}/robotcode/VariableValueProgramItem.o: robotcode/VariableValueProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/VariableValueProgramItem.o robotcode/VariableValueProgramItem.cpp

${OBJECTDIR}/robotcode/WhileProgramItem.o: robotcode/WhileProgramItem.cpp 
	${MKDIR} -p ${OBJECTDIR}/robotcode
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/robotcode/WhileProgramItem.o robotcode/WhileProgramItem.cpp

${OBJECTDIR}/stdafx.o: stdafx.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I/usr/include/mysql -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/stdafx.o stdafx.cpp

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/robominercpp

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
